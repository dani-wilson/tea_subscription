require "rails_helper"

RSpec.describe "creating a tea subscription" do
  it "should subscribe a customer to a tea subscription" do
    customer = create(:customer)
    tea = create(:tea)
    subscription = create(:subscription, customer: customer, tea: tea)

    post "/api/v0/subscriptions"

    expect(response).to be_successful
    expect(response.status).to eq(201)
  end
end