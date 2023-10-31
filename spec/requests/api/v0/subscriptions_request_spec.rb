require "rails_helper"

RSpec.describe "the tea subscription" do
  describe "creating a tea subscription" do
    it "HAPPY PATH: should subscribe a customer to a tea subscription" do
      customer = create(:customer)
      tea = create(:tea)
  
      subscription_params = ({
        "title": "Biweekly Orange Rooibos",
        "price": "12.50",
        "status": "0",
        "frequency": "Biweekly",
        "customer_id": customer.id,
        "tea_id": tea.id
      })
  
      post "/api/v0/subscriptions", params: subscription_params, as: :json
  
      expect(response).to be_successful
      expect(response.status).to eq(201)
  
      created_subscription = Subscription.last
  
      expect(JSON.parse(response.body)["message"]).to eq("Biweekly Orange Rooibos added.")
  
      expect(created_subscription.title).to eq("Biweekly Orange Rooibos")
      expect(created_subscription.price).to eq(12.5)
      expect(created_subscription.status).to eq(0)
      expect(created_subscription.frequency).to eq("Biweekly")
    end
  
    it "SAD PATH: cannot create a subscription without a customer id" do
      tea = create(:tea)
  
      subscription_params = ({
        "title": "Biweekly Orange Rooibos",
        "price": "12.50",
        "status": "0",
        "frequency": "Biweekly",
        "tea_id": tea.id
      })
  
      post "/api/v0/subscriptions", params: subscription_params, as: :json
  
      expect(response).to_not be_successful
      expect(response.status).to eq(404)
  
      parsed = JSON.parse(response.body, symbolize_names: true)
  
      expect(parsed[:errors][0][:title]).to eq("Validation failed: Customer must exist")
    end
  
    it "SAD PATH: cannot create a subscription without a tea id" do
      customer = create(:customer)
  
      subscription_params = ({
        "title": "Biweekly Orange Rooibos",
        "price": "12.50",
        "status": "0",
        "frequency": "Biweekly",
        "customer_id": customer.id
      })
  
      post "/api/v0/subscriptions", params: subscription_params, as: :json
  
      expect(response).to_not be_successful
      expect(response.status).to eq(404)
  
      parsed = JSON.parse(response.body, symbolize_names: true)
  
      expect(parsed[:errors][0][:title]).to eq("Validation failed: Tea must exist")
    end
  end

  describe "canceling the tea subscription" do
    it "HAPPY PATH: should delete a tea subscription" do
      customer = create(:customer)
      tea = create(:tea)
      subscription = create(:subscription, customer: customer, tea: tea)

      delete "/api/v0/subscriptions/#{subscription.id}"
      
      expect(response).to be_successful
      expect(response.status).to eq(200)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:message]).to eq("#{subscription.title} deleted.")
    end

    it "SAD PATH: cannot delete a tea subscription that does not exist" do
      delete "/api/v0/subscriptions/11"
      
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      parsed = JSON.parse(response.body, symbolize_names: true)
  
      expect(parsed[:errors][0][:title]).to eq("Couldn't find Subscription with 'id'=11")
    end
  end
end