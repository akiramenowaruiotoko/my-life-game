FactoryBot.define do
  factory :target do
    content { Faker::Lorem.sentence }
    target_date { Faker::Date.backward }
    user_id { Faker::Number.number }
    association :user
  end
end
