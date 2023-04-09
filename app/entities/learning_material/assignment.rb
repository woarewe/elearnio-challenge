# frozen_string_literal: true

module Types
  module LearningMaterial
    module Assignment
      Error = Class.new(StandardError)
      AssigningToAuthorError = Class.new(Error)
      AssigningNotPublishedError = Class.new(Error)
      AlreadyCompletedError = Class.new(Error)

      module Validations
        def validate_assignment!(material)
          raise LearningMaterial::Assignment::AssigningNotPublishedError unless material.published?
          raise LearningMaterial::Assignment::AssigningToAuthorError if material.author?(talent)
        end
      end
    end
  end
end
