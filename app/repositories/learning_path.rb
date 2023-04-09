# frozen_string_literal: true

module Repositories
  class LearningPath < Base
    include LearningMaterial

    entity Types::LearningPath

    extend ClassMethods

    Error = Class.new(StandardError)
    NameDuplicationError = Class.new(Error)

    has_many :slots, -> { positioned }, class_name: "Slot", dependent: nil, inverse_of: :learning_path
    has_many :courses, through: :slots
    has_many :assignments, class_name: "Assignment", dependent: nil

    belongs_to :author, class_name: "Talent"

    def override_entity_attributes
      { author: author.entity, courses: courses.map(&:entity) }
    end
  end
end
