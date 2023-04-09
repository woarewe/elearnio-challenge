# frozen_string_literal: true

module Types
  class Course
    class Assignment < Struct
      include Entity
      include LearningMaterial::Assignment

      Error = Class.new(StandardError)

      def complete!
        completed_guard! { update_properties(status: LearningMaterial::AssignmentStatus::COMPLETED) }
      end

      private

      def completed_guard!
        raise AlreadyCompletedError if properties.status == LearningMaterial::AssignmentStatus::COMPLETED

        yield
      end
    end
  end
end
