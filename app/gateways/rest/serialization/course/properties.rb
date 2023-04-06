# frozen_string_literal: true

module REST
  module Serialization
    class Course
      class Properties < Base
        expose :author, using: Talent
        expose :name
        expose :content
        expose :status
      end
    end
  end
end
