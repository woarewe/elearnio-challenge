# frozen_string_literal: true

FactoryBot.define do
  factory :course_properties, class: "Types::Course::Properties" do
    name { Faker::Lorem.unique.question }
    author { build(:talent) }
    status { Types::LearningMaterial::Status.enum.values.sample }
    content { Faker::Lorem.paragraph }

    trait :published do
      status { Types::LearningMaterial::Status::PUBLISHED }
    end

    trait :draft do
      status { Types::LearningMaterial::Status::DRAFT }
    end

    initialize_with { new(name:, author:, status:, content:) }
  end
end
