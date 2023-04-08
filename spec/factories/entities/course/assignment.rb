# frozen_string_literal: true

FactoryBot.define do
  factory :course_assignment, class: "Types::Course::Assignment" do
    properties { build(:course_assignment_properties) }
    sequence(:private_id, 1, &:itself)
    public_id { SecureRandom.uuid }
    timestamps { build(:timestamps) }

    trait :in_progress do
      properties { build(:course_assignment_properties, :in_progress) }
    end

    trait :completed do
      properties { build(:course_assignment_properties, :completed) }
    end

    initialize_with { new(properties:, timestamps:, public_id:, private_id:) }
  end
end
