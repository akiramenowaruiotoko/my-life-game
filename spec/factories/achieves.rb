FactoryBot.define do
  factory :achieve do
    target_id { Faker::Number.number }
    association :target
  end
end
