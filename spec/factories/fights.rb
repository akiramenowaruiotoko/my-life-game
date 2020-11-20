FactoryBot.define do
  factory :fight do
    user_id { Faker::Number.number }
    target_id { Faker::Number.number }
    association :user
    association :target
  end
end
