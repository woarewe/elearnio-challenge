# frozen_string_literal: true

module REST
  class API
    class Courses
      class Create < Base
        desc "Create a course"
        post do
          handle_execution_errors do
            validate!(params, with: Validation::Course::Properties)
              .then { |validated| ::Services::Course::Create.new.call(validated) }
              .then { |entity| present entity, with: Serialization::Course }
          end
        end
      end
    end
  end
end
