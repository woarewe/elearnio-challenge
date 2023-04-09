# frozen_string_literal: true

module REST
  class API
    class Courses
      class Create < Base
        class Contract < Dry::Validation::Contract
          json do
            required(:name).filled(Types::Name)
            required(:content).filled(Types::String)
            required(:author_id).filled(Types::ID::Public)
          end
        end

        desc "Create a course"
        post do
          handle_execution_errors do
            validate!(params, with: Contract)
              .then { |validated| ::Services::Course::Create.new.call(validated) }
              .then { |entity| present entity, with: Serialization::Course }
          end
        end
      end
    end
  end
end
