# frozen_string_literal: true

module Types
  module LearningMaterial
    module Status
      DRAFT = "draft"
      PUBLISHED = "published"

      def self.enum
        Types::String.enum(DRAFT, PUBLISHED)
      end
    end
  end
end
