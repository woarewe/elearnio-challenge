# frozen_string_literal: true

module Types
  class LearningPath
    class Properties < Struct
      attribute :name, Name
      attribute :author, Talent
      attribute :status, LearningMaterial::Status.enum
      attribute :courses, Types::Array.of(Course).constrained(min_size: 1)

      private

      def additional_checks!(*)
        validate_courses!
      end

      def validate_courses!
        not_published = courses.select(&:draft?)
        raise NotPublishedCoursesError, not_published if not_published.any?
      end
    end
  end
end
