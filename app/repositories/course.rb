# frozen_string_literal: true

module Repositories
  class Course < Base
    include LearningMaterial

    entity Types::Course

    extend ClassMethods

    Error = Class.new(Error)
    NameDuplicationError = Class.new(Error)

    belongs_to :author, class_name: "Talent"

    has_many :assignments, class_name: "Assignment"
    has_many :learning_path_slots, class_name: "LearningPath::Slot"
    has_many :learning_paths, through: :learning_path_slots

    def override_entity_attributes
      { author: author.entity }
    end
  end
end
