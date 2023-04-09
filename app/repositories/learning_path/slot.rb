# frozen_string_literal: true

module Repositories
  class LearningPath
    class Slot < Base
      belongs_to :learning_path, inverse_of: :slots
      belongs_to :course

      scope :positioned, -> { order(position: :asc) }
    end
  end
end
