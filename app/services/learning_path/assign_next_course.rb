# frozen_string_literal: true

module Services
  module LearningPath
    class AssignNextCourse
      def call(learning_path:, talent:)
        assignments = current_progress(learning_path:, talent:)
        course = learning_path.next_course(assignments)
        return if course.nil?

        create_assignment(course:, talent:)
      end

      private

      def current_progress(learning_path:, talent:)
        Repositories::Course::Assignment
          .joins(course: [:assignments, :learning_path_slots])
          .where(learning_path_slots: { learning_path_id: learning_path.private_id })
          .where(course_assignments: { talent_id: talent.private_id })
          .map(&:entity)
      end

      def create_assignment(course:, talent:)
        assignment = Types::Course::Assignment::Properties.new(
          course:,
          talent:,
          status: ::Types::LearningMaterial::AssignmentStatus::IN_PROGRESS
        )
        ignore_duplication_error do
          ::Repositories::Course::Assignment.save!(assignment)
        end
      end

      def ignore_duplication_error
        yield
      rescue ::Repositories::LearningMaterial::Assignment::AlreadyAssignedError # rubocop:disable Lint/SuppressedException
      end
    end
  end
end
