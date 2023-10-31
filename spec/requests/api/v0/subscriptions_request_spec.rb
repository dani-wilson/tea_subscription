require "rails_helper"

RSpec.describe "creating a tea subscription" do
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
end