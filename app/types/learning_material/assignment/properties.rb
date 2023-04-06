# frozen_string_literal: true

module Types
  module LearningMaterial
    class Assignment
      class Properties < Struct
        attribute :talent, Talent
        attribute :learning_material, LearningPath | Course
        attribute :status, Status
      end
    end
  end
end
