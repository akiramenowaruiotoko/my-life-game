FactoryBot.define do
  factory :user do
    name              { Faker::Name.initials(number: 6) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    free_time             { '16:00:00' }
    private_mode          { Faker::Boolean.boolean }
  end
end
