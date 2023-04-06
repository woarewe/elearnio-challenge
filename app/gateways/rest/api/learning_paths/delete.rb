# frozen_string_literal: true

module REST
  class API
    class LearningPaths
      class Delete < Base
        desc "Delete a learning_path"
        delete do
          status 204
          learning_path = find_requested_learning_path!
          if learning_path.published?
            invalid!(:id,
                     I18n.t!("rest.learning_materials.errors.deleting_published",
                             material: "learning path"))
          end

          transaction do
            ::LearningPath.connected_record(learning_path).slots.destroy_all
            ::LearningPath.delete(learning_path.private_id)
          end
        end
      end
    end
  end
end
