# frozen_string_literal: true

FactoryBot.define do
  factory :learning_path do
    association :author, factory: :talent

    name { Faker::Lorem.unique.sentence }
    status { Types::LearningMaterial::Status.enum.values.sample }
    created_at { 2.days.ago }
    updated_at { 1.day.ago }
    id { Faker::Number.unique.positive }
    public_id { SecureRandom.uuid }

    trait :published do
      status { Types::LearningMaterial::Status::PUBLISHED }
    end

    trait :draft do
      status { Types::LearningMaterial::Status::DRAFT }
    end
  end
end
