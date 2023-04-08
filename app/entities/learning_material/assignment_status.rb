# frozen_string_literal: true

module Types
  module LearningMaterial
    module AssignmentStatus
      IN_PROGRESS = "in_progress"
      COMPLETED = "completed"

      def self.enum
        Types::String.enum(IN_PROGRESS, COMPLETED)
      end
    end
  end
end
