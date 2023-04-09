# frozen_string_literal: true

module Repositories
  class Course < Base
    include LearningMaterial

    entity Types::Course

    Error = Class.new(Error)
    NameDuplicationError = Class.new(Error)

    belongs_to :author, class_name: "Talent"

    class << self
      def serialize_property_attributes_with_different_names(properties)
        { author: Talent.connected_record(properties.author) }
      end

      def handle_database_errors
        yield
      rescue ActiveRecord::RecordNotUnique
        raise NameDuplicationError
      end
    end

    def override_entity_attributes
      { author: author.entity }
    end
  end
end
