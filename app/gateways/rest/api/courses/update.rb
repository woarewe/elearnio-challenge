# frozen_string_literal: true

module REST
  class API
    class Courses
      class Update < Base
        class Contract < Dry::Validation::Contract
          json do
            required(:name).filled(Types::Name)
            required(:content).filled(Types::String)
            required(:author_id).filled(Types::ID::Public)
          end
        end

        desc "Update a course content"
        put do
          handle_execution_errors do
            course = find_requested_resource!
            validate!(params, with: Contract)
              .then { |validated| ::Services::Course::Update.new.call(course:, params: validated) }
              .then { |entity| present entity, with: Serialization::Course }
          end
        end
      end
    end
  end
end
