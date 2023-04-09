# frozen_string_literal: true

module REST
  class API
    module Helpers
      module LearningPaths
        module Assignments
          def assigning_to_errors
            [
              ::Types::LearningMaterial::Assignment::AssigningToAuthorError,
              ::Types::LearningPath::Assignment::AssigningToCourseAuthorError
            ]
          end

          def learning_material
            :learning_path
          end

          def find_requested_resource!(includes = {})
            params => { id: public_id }
            ::Repositories::LearningPath::Assignment
              .includes(includes)
              .seek(public_id)
              .tap { |resource| not_found!(:id) if resource.nil? }
          end
        end
      end
    end
  end
end
