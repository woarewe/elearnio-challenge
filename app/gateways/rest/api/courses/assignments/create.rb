# frozen_string_literal: true

module REST
  class API
    class Courses
      class Assignments
        class Create < Base
          class Contract < Dry::Validation::Contract
            json do
              required(:talent_id).filled(Types::ID::Public)
              required(:course_id).filled(Types::ID::Public)
            end
          end

          desc "Assign a course to a student"
          post do
            handle_execution_errors do
              validate!(params, with: Contract)
                .then { |validated| ::Services::Course::Assignment::Create.new.call(validated) }
                .then { |entity| present entity, with: Serialization::Course::Assignment }
            end
          end
        end
      end
    end
  end
end
