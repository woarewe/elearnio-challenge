# frozen_string_literal: true

module REST
  class API
    class Courses
      class Update < Base
        desc "Update a course content"
        put do
          handle_execution_errors do
            course = find_requested_resource!
            validate!(params, with: Validation::Course::Properties)
              .then { |validated| ::Services::Course::Update.new.call(course:, params: validated) }
              .then { |entity| present entity, with: Serialization::Course }
          end
        end
      end
    end
  end
end
