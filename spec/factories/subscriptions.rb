FactoryBot.define do
  factory :subscriptions do
    title { "#{Faker::Subscription.subscription_term} #{Faker::Tea.variety}" }
    price { Faker::Number.decimal(l_digits: 2, r_digits: 2)}
    status { Faker::Number.between(from: 0, to: 1)}
    frequency { Faker::Subscription.subscription_term }
  end
end