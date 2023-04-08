# frozen_string_literal: true

module Types
  class Course
    class Assignment < Struct
      include Entity

      Error = Class.new(StandardError)
      AssigningToAuthorError = Class.new(Error)
      AssigningNotPublishedCourseError = Class.new(Error)
    end
  end
end
