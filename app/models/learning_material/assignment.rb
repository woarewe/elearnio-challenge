# frozen_string_literal: true

module LearningMaterial
  class Assignment < ApplicationRecord
    include Repository

    belongs_to :learning_material, polymorphic: true, inverse_of: :assignments
    belongs_to :talent, inverse_of: :assignments
  end
end
