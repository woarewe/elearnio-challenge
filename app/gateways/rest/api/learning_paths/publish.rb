# frozen_string_literal: true

module REST
  class API
    class LearningPaths
      class Publish < Base
        desc "Publish a learning path"
        patch :publish do
          handle_execution_errors do
            learning_path = find_requested_resource!
            learning_path
              .publish!
              .then { |entity| ::Repositories::LearningPath.save!(entity).entity }
              .then { |entity| present entity, with: Serialization::LearningPath }
          end
        end
      end
    end
  end
end
