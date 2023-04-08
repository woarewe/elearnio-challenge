# frozen_string_literal: true

FactoryBot.define do
  factory :talent_properties, class: "Types::Talent::Properties" do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }

    initialize_with { new(first_name:, last_name:, email:) }
  end
end
