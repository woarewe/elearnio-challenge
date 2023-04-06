# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    association :author, factory: :talent

    name { Faker::Lorem.unique.sentence }
    status { Types::Course::Status.type.values.sample }
    created_at { 2.days.ago }
    updated_at { 1.day.ago }
    content { Faker::Lorem.paragraph }
    id { Faker::Number.unique.positive }
    public_id { SecureRandom.uuid }

    trait :published do
      status { Types::Course::Status::PUBLISHED }
    end

    trait :draft do
      status { Types::Course::Status::DRAFT }
    end
  end
end
