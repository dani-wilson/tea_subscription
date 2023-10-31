Tea.destroy_all 
Customer.destroy_all
Subscription.destroy_all

require "faker"
require "factory_bot_rails"

5.times do
  FactoryBot.create(:customer)
end

20.times do
  FactoryBot.create(:tea)
end

10.times do
  FactoryBot.create(:subscription, customer: Customer.all.sample, tea: Tea.all.sample)
end


