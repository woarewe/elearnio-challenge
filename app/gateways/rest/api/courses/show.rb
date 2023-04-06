# frozen_string_literal: true

module REST
  class API
    class Courses
      class Show < Base
        desc "Show a course"
        get do
          find_requested_course!
            .then { |entity| present entity, with: Serialization::Course }
        end
      end
    end
  end
end
