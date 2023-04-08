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
      published_guard! { update_courses(courses) }
    end

    def co_authors
      properties.courses.map { |course| course.properties.author }
    end

    private

    def update_courses(courses)
      updated_properties = Properties.new(properties.to_h.merge(courses:))
      update_properties(updated_properties)
    end
  end
end
