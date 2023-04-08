# frozen_string_literal: true

module Types
  module LearningMaterial
    class Assignment < Struct
      include Entity

      Error = Class.new(StandardError)
      AssigningToAuthorError = Class.new(Error)
      AssigningToCoAuthorError = Class.new(Error)
      NotPublishedLearningMaterialError = Class.new(Error)
    end
  end
end
