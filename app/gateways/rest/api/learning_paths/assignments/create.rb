# frozen_string_literal: true

module REST
  class API
    class LearningPaths
      class Assignments
        class Create < Base
          class Contract < Dry::Validation::Contract
            json do
              required(:talent_id).filled(Types::ID::Public)
              required(:learning_path_id).filled(Types::ID::Public)
            end
          end

          desc "Assign a learning path to a talent"
          post do
            handle_execution_errors do
              validate!(params, with: Contract)
                .then { |validated| ::Services::LearningPath::Assignment::Create.new.call(validated) }
                .then { |entity| present entity, with: Serialization::LearningPath::Assignment }
            end
          end
        end
      end
    end
  end
end
