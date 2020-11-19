FactoryBot.define do
  factory :target do
    content { Faker::Lorem.sentence }
    target_date { Faker::Date.backward }
    association :user
  end
end
