# frozen_string_literal: true

module Tests
  module Helpers
    module Repositories
      module LearningPath
        module Assignment
          module_function

          def persist_learning_path_assignment!(entity)
            talent = Talent.persist_talent!(entity.talent)
            record = ::Repositories::LearningPath::Assignment.find_or_create_by!(
              id: entity.private_id,
              public_id: entity.public_id,
              created_at: entity.timestamps.created_at,
              updated_at: entity.timestamps.updated_at,
              talent:,
              learning_path: LearningPath.persist_learning_path!(entity.learning_path)
            )
            course_to_assign = entity.learning_path.courses.find do |course|
              ::Repositories::Course::Assignment.find_by(
                course_id: course.private_id,
                talent:,
                status: ::Types::LearningMaterial::AssignmentStatus::COMPLETED
              ).nil?
            end

            ::Repositories::Course::Assignment.find_or_create_by!(
              course_id: course_to_assign.private_id,
              status: ::Types::LearningMaterial::AssignmentStatus::IN_PROGRESS,
              talent:
            )
            record
          end

          def persist_learning_path_assignments!(entities)
            entities.map { |entity| persist_learning_path_assignment!(entity) }
          end
        end
      end
    end
  end
end
