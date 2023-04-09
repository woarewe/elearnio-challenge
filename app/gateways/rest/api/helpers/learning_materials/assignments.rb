# frozen_string_literal: true

module REST
  class API
    module Helpers
      module LearningMaterials
        module Assignments
          def handle_execution_errors
            yield
          rescue ::Repositories::LearningMaterial::Assignment::AlreadyAssignedError
            validation_error!(:course_id, I18n.t("rest.learning_materials.errors.already_assigned"))
          rescue ::Services::NotFoundError => error
            validation_error!(error.key, error.message)
          rescue ::Types::LearningMaterial::Assignment::AssigningNotPublishedError
            assigning_not_published!
          rescue *assigning_to_errors
            assigning_to_author!
          end

          def already_assigned_key
            "#{learning_material}_id"
          end

          def assigning_not_published!
            validation_error!(
              :course_id,
              I18n.t!("rest.learning_materials.errors.assigning_not_published", material: learning_material.to_s)
            )
          end

          def assigning_to_author!
            validation_error!(
              :talent_id,
              I18n.t!("rest.learning_materials.errors.assigning_to_author")
            )
          end

          def already_completed!
            validation_error!(
              :id,
              I18n.t!("rest.learning_materials.errors.already_completed")
            )
          end
        end
      end
    end
  end
end
