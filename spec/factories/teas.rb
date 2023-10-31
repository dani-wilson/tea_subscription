FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::TvShows::MichaelScott.quote }
    temperature { Faker::Number.decimal(l_digits: 2, r_digits: 1)}
    brew_time { Faker::Number.between(from: 3, to: 15) }
  end
end