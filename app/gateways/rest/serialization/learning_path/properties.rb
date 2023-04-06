# frozen_string_literal: true

module REST
  module Serialization
    class LearningPath
      class Properties < Base
        expose :author, using: Talent
        expose :name
        expose :status
        expose :courses, using: Course
      end
    end
  end
end
