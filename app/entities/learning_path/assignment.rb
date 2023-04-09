# frozen_string_literal: true

module Types
  class LearningPath
    class Assignment < Struct
      include Entity
      include LearningMaterial::Assignment

      Error = Class.new(StandardError)
      AssigningToCourseAuthorError = Class.new(Error)
    end
  end
end
