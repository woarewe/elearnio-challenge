# frozen_string_literal: true

module REST
  class API
    module Helpers
      module Courses
        module Assignments
          def assigning_to_errors
            [::Types::LearningMaterial::Assignment::AssigningToAuthorError]
          end

          def learning_material
            :course
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
