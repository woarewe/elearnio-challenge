# frozen_string_literal: true

module Types
  class LearningPath
    class Assignment
      class Properties < Struct
        include LearningMaterial::Assignment::Validations

        attribute :learning_path, LearningPath
        attribute :talent, Talent

        private

        def additional_checks!(*)
          validate_assignment!(learning_path)
          raise AssigningToCourseAuthorError if course_author?(talent)
        end

        def course_author?(talent)
          learning_path.courses.any? { |course| course.author?(talent) }
        end
      end
    end
  end
end
