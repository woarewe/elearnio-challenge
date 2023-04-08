# frozen_string_literal: true

module Types
  module LearningMaterial
    class Assignment
      class Properties < Struct
        attribute :talent, Talent
        attribute :learning_material, LearningPath | Course
        attribute :status, Status

        private

        def additional_checks!(*)
          raise AssigningToAuthorError if learning_material.author?(talent)
          raise AssigningToCoAuthorError if learning_material.co_author?(talent)
          raise NotPublishedLearningMaterialError unless learning_material.published?
        end
      end
    end
  end
end
