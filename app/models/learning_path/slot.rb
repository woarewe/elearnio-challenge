# frozen_string_literal: true

class LearningPath
  class Slot < ApplicationRecord
    belongs_to :learning_path, inverse_of: :slots
    belongs_to :course

    scope :positioned, -> { order(position: :asc) }
  end
end
