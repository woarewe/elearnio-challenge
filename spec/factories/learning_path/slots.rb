# frozen_string_literal: true

FactoryBot.define do
  factory :learning_path_slot, class: "LearningPath::Slot" do
    association :course
    association :learning_path
  end
end
