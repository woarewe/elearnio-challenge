# frozen_string_literal: true

module Types
  class Course
    class Assignment
      class Properties < Struct
        attribute :course, Course
        attribute :talent, Talent
        attribute :status, LearningMaterial::AssignmentStatus.enum

        private

        def additional_checks!(*)
          raise AssigningNotPublishedCourseError unless course.published?
          raise AssigningToAuthorError if course.author?(talent)
        end
      end
    end
  end
end
