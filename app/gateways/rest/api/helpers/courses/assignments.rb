# frozen_string_literal: true

module REST
  class API
    module Helpers
      module Courses
        module Assignments
          def handle_execution_errors
            yield
          rescue ::Repositories::Course::Assignment::AlreadyAssignedError
            validation_error!(:course_id, I18n.t("rest.learning_materials.errors.already_assigned"))
          rescue ::Services::NotFoundError => error
            validation_error!(error.key, error.message)
          rescue ::Types::Course::Assignment::AssigningNotPublishedCourseError
            assigning_not_published!
          rescue ::Types::Course::Assignment::AssigningToAuthorError
            assigning_to_author!
          end

          def assigning_not_published!
            validation_error!(
              :course_id,
              I18n.t!("rest.learning_materials.errors.assigning_not_published", material: "course")
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

          def find_requested_resource!(includes = {})
            params => { id: public_id }
            ::Repositories::Course::Assignment
              .includes(includes)
              .seek(public_id)
              .tap { |resource| not_found!(:id) if resource.nil? }
          end
        end
      end
    end
  end
end
