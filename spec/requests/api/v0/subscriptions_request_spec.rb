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

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }

      body = JSON.generate(subscription_params)
  
      post "/api/v0/subscriptions", headers: headers, params: body
  
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

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }

      body = JSON.generate(subscription_params)
  
      post "/api/v0/subscriptions", headers: headers, params: body
    
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

      headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }

      body = JSON.generate(subscription_params)
  
      post "/api/v0/subscriptions", headers: headers, params: body
    
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

  describe "viewing all tea subscriptions for a customer" do
    it "HAPPY PATH: can view all tea subscriptions for a customer" do
      create(:customer)
      
      create_list(:tea, 20)

      create_list(:subscription, 10, customer: Customer.first, tea: Tea.all.sample)

      get "/api/v0/customers/1/subscriptions"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      subscriptions = JSON.parse(response.body, symbolize_names: true)
      
      subscriptions.each do |subscription|
        expect(subscription).to have_key(:id)
        expect(subscription[:id]).to be_an(Integer)
        expect(subscription).to have_key(:title)
        expect(subscription[:title]).to be_a(String)
        expect(subscription).to have_key(:price)
        expect(subscription[:price]).to be_a(Float)
        expect(subscription).to have_key(:status)
        expect(subscription[:status]).to be_an(Integer)
        expect(subscription).to have_key(:frequency)
        expect(subscription[:frequency]).to be_a(String)
      end
    end
  end
end