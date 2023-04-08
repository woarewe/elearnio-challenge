# frozen_string_literal: true

module Types
  module LearningMaterial
    class Assignment
      class Status < Struct
        NOT_STARTED = "not_started"
        IN_PROGRESS = "in_progress"
        COMPLETED = "completed"

        def self.enum
          Types::String.enum(NOT_STARTED, IN_PROGRESS, COMPLETED)
        end

        attribute :name, enum
        attribute :timestamp, Types::DateTime
      end
    end
  end
end
