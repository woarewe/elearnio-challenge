# frozen_string_literal: true

module Repository
  module ClassMethods
    def entity(entity_class)
      @entity_class = entity_class
    end

    attr_reader :entity_class

    def save!(entity_or_properties)
      handle_database_errors { unsafe_save!(entity_or_properties) }
    end

    def find_by_public_id(public_id)
      find_by(public_id:)&.entity
    end

    def unsafe_save!(entity_or_properties)
      case entity_or_properties
      when entity_class
        save_entity!(entity_or_properties)
      when entity_class::Properties
        save_properties!(entity_or_properties)
      else
        raise TypeError, "unknown type to persist"
      end
    end

    def save_entity!(entity)
      record = connected_record(entity)
      record.update!(serialize_entity_properties(entity.properties))
      record.entity
    end

    def save_properties!(properties)
      record = create!(serialize_entity_properties(properties))
      record.entity
    end

    def connected_record(entity)
      find(entity.private_id)
    end

    def serialize_timestamps(timestamps)
      timestamps.as_json
    end

    def serialize_entity_properties(properties)
      properties.as_json.with_indifferent_access.merge(
        serialize_entity_properties_relations(properties)
      )
    end

    def serialize_entity_properties_relations(_properties)
      {}
    end

    def serialize_entity(entity)
      {
        **serialize_entity_properties(entity.properties),
        **serialize_timestamps(entity.timestamps),
        id: entity.private_id,
        public_id: entity.public_id
      }
    end

    def handle_database_errors
      yield
    end

    def property_class
      entity_class::Properties
    end
  end
end
