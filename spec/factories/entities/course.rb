# frozen_string_literal: true

FactoryBot.define do
  factory :course, class: "Types::Course" do
    properties { build(:course_properties) }
    sequence(:private_id, 1, &:itself)
    public_id { SecureRandom.uuid }
    timestamps { build(:timestamps) }

    trait :published do
      properties { build(:course_properties, :published) }
    end

    trait :draft do
      properties { build(:course_properties, :draft) }
    end

    initialize_with { new(properties:, timestamps:, public_id:, private_id:) }
  end
end
