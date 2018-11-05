require 'faker'

FactoryBot.define do
  factory :product do
    title { Faker::Vehicle.manufacture }
    price { rand() *100 }
    published false
    user_id "1"
  end
end
