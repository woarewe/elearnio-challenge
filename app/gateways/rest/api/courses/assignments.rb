# frozen_string_literal: true

module REST
  class API
    class Courses
      class Assignments < Base
        helpers(Helpers::Courses::Assignments)

        mount Create

        route_param :id do
          mount Complete
        end
      end
    end
  end
end
