# frozen_string_literal: true

FactoryBot.define do
  factory :timestamps, class: "Types::Timestamps" do
    created_at { DateTime.now }
    updated_at { DateTime.now }

    initialize_with { new(created_at:, updated_at:) }
  end
end
