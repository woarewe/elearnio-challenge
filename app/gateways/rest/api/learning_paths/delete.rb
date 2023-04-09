# frozen_string_literal: true

module REST
  class API
    class LearningPaths
      class Delete < Base
        desc "Delete a learning_path"
        delete do
          status 204
          learning_path = find_requested_resource!
          if learning_path.published?
            invalid!(
              :id,
              I18n.t!("rest.learning_materials.errors.deleting_published", material: "learning path")
            )
          end

          transaction do
            ::Repositories::LearningPath.delete!(learning_path)
          end
        end
      end
    end
  end
end
