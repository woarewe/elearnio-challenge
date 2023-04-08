# frozen_string_literal: true

FactoryBot.define do
  factory :learning_material_assignment_status, class: "Types::LearningMaterial::Assignment::Status" do
    timestamp { DateTime.now }
    name { Types::LearningMaterial::Assignment::Status.enum.values.sample }

    initialize_with { new(name:, timestamp:) }
  end
end
