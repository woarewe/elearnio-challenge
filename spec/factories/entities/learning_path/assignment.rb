# frozen_string_literal: true

FactoryBot.define do
  factory :learning_path_assignment, class: "Types::LearningPath::Assignment" do
    properties { build(:learning_path_assignment_properties) }
    sequence(:private_id, 1, &:itself)
    public_id { SecureRandom.uuid }
    timestamps { build(:timestamps) }

    initialize_with { new(properties:, timestamps:, public_id:, private_id:) }
  end
end
