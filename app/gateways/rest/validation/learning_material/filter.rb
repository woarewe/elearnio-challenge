# frozen_string_literal: true

module REST
  module Validation
    module LearningMaterial
      class Filter < Dry::Validation::Contract
        params do
          optional(:author_ids).array(::Types::ID::Public)
          optional(:name).filled(::Types::Name)
          optional(:statuses).array(::Types::LearningMaterial::Status.enum)
        end
      end
    end
  end
end
