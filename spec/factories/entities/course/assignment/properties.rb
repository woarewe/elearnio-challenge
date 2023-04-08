# frozen_string_literal: true

FactoryBot.define do
  factory :course_assignment_properties, class: "Types::Course::Assignment::Properties" do
    course { build(:course, :published) }
    talent { build(:talent) }
    status { Types::LearningMaterial::AssignmentStatus.enum.values.sample }

    trait :in_progress do
      status { Types::LearningMaterial::AssignmentStatus::IN_PROGRESS }
    end

    trait :completed do
      status { Types::LearningMaterial::AssignmentStatus::COMPLETED }
    end

    initialize_with { new(course:, talent:, status:) }
  end
end
