# frozen_string_literal: true

module Types
  class Course
    class Assignment
      class Properties < Struct
        include LearningMaterial::Assignment::Validations

        attribute :course, Course
        attribute :talent, Talent
        attribute :status, LearningMaterial::AssignmentStatus.enum

        private

        def additional_checks!(...)
          validate_assignment!(course)
        end
      end
    end
  end
end
