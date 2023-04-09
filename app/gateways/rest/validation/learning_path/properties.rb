# frozen_string_literal: true

module REST
  module Validation
    module LearningPath
      class Properties < Dry::Validation::Contract
        json do
          required(:name).filled(Types::Name)
          required(:author_id).filled(Types::ID::Public)
          required(:course_ids).value(Types::Array.of(Types::ID::Public).constrained(min_size: 1))
        end
      end
    end
  end
end
