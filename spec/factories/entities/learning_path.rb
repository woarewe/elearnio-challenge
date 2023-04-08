# frozen_string_literal: true

FactoryBot.define do
  factory :learning_path, class: "Types::LearningPath" do
    sequence(:private_id, 1, &:itself)
    public_id { SecureRandom.uuid }
    properties { build(:learning_path_properties) }
    timestamps { build(:timestamps) }

    trait :published do
      properties { build(:learning_path_properties, :published) }
    end

    trait :draft do
      properties { build(:learning_path_properties, :draft) }
    end

    initialize_with { new(private_id:, public_id:, properties:, timestamps:) }
  end
end
