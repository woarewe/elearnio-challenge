# frozen_string_literal: true

module REST
  class API
    class LearningPaths
      class Create < Base
        desc "Create a learning path"
        post do
          handle_execution_errors do
            validate!(params, with: Validation::LearningPath::Properties)
              .then { |properties| Services::LearningPath::Create.new.call(properties) }
              .then { |entity| present entity, with: Serialization::LearningPath }
          end
        end
      end
    end
  end
end
