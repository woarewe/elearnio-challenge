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

    def update_courses!(courses)
      published_guard! { update_properties(courses:) }
    end
  end
end
