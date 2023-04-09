# frozen_string_literal: true

module REST
  module Serialization
    class Course
      class Assignment
        class Properties < Base
          expose :talent, using: Talent
          expose :course, using: Course
          expose :status
        end
      end
    end
  end
end
