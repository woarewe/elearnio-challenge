# frozen_string_literal: true

module REST
  class API
    class LearningPaths
      class Update < Base
        desc "Update a learning_path content"
        put do
          handle_execution_errors do
            learning_path = find_requested_resource!
            validate!(params, with: Validation::LearningPath::Properties)
              .then { |validated| Services::LearningPath::Update.new.call(learning_path:, params: validated) }
              .then { |entity| present entity, with: Serialization::LearningPath }
          end
        end
      end
    end
  end
end
