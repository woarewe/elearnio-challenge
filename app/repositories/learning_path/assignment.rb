# frozen_string_literal: true

module Repositories
  class LearningPath
    class Assignment < Base
      include LearningMaterial::Assignment

      entity Types::LearningPath::Assignment

      belongs_to :learning_path
      belongs_to :talent

      class << self
        def serialize_property_attributes_with_different_names(properties)
          {
            talent: Talent.connected_record(properties.talent),
            learning_path: LearningPath.connected_record(properties.learning_path)
          }
        end
      end

      def override_entity_attributes
        { talent: talent.entity, learning_path: learning_path.entity }
      end
    end
  end
end
