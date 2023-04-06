# frozen_string_literal: true

FactoryBot.define do
  factory :talent do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    created_at { 2.days.ago }
    updated_at { 1.day.ago }
    id { Faker::Number.unique.positive }
    public_id { SecureRandom.uuid }

    trait :unique do
      first_name { Faker::Name.unique.first_name }
      last_name { Faker::Name.unique.last_name }
      email { Faker::Internet.unique.email }
    end
  end
end
