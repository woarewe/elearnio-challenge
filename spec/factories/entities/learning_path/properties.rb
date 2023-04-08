# frozen_string_literal: true

FactoryBot.define do
  factory :learning_path_properties, class: "Types::LearningPath::Properties" do
    name { Faker::Lorem.unique.question }
    author { build(:talent) }
    status { Types::LearningMaterial::Status.enum.values.sample }
    courses { build_list(:course, 3, :published) }

    trait :published do
      status { Types::LearningMaterial::Status::PUBLISHED }
    end

    trait :draft do
      status { Types::LearningMaterial::Status::DRAFT }
    end

    initialize_with { new(name:, author:, status:, courses:) }
  end
end
