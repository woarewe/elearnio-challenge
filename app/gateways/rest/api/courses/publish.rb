# frozen_string_literal: true

module REST
  class API
    class Courses
      class Publish < Base
        desc "Publish a course"
        patch :publish do
          handle_execution_errors do
            find_requested_resource!
              .publish!
              .then { |entity| ::Repositories::Course.save!(entity).entity }
              .then { |entity| present entity, with: Serialization::Course }
          end
        end
      end
    end
  end
end
