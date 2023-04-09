# frozen_string_literal: true

module Types
  class LearningPath < Struct
    include Entity
    include LearningMaterial

    Error = Class.new(StandardError)

    class NotPublishedCoursesError < Error
      attr_reader :courses

      def initialize(courses)
        @courses = courses
        super("")
      end
    end

    def next_course(assignments)
      progress = progress_table(assignments)
      return if assignments.any?(&:in_progress?)

      courses.find do |course|
        progress[course.private_id].nil?
      end
    end

    def update_courses!(courses)
      published_guard! { update_properties(courses:) }
    end

    private

    def progress_table(assignments)
      assignments.index_by do |assignment|
        assignment.course.private_id
      end
    end
  end
end
