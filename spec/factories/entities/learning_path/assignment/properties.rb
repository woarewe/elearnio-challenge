# frozen_string_literal: true

FactoryBot.define do
  factory :learning_path_assignment_properties, class: "Types::LearningPath::Assignment::Properties" do
    learning_path { build(:learning_path, :published) }
    talent { build(:talent) }

    initialize_with { new(learning_path:, talent:) }
  end
end
