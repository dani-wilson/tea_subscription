FactoryBot.define do
  factory :subscription do
    title { "#{Faker::Subscription.subscription_term} #{Faker::Tea.variety}" }
    price { Faker::Number.decimal(l_digits: 2, r_digits: 2)}
    status { Faker::Number.between(from: 0, to: 1)}
    frequency { Faker::Subscription.subscription_term }
    tea_id { Faker::Number.between(from: 1, to: 20)}
    customer_id { Faker::Number.between(from: 1, to: 5)}
  end
end