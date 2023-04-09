# frozen_string_literal: true

module Repositories
  class Base
    module ClassMethods
      def save!(entity_or_properties)
        record = handle_database_errors { unsafe_save!(entity_or_properties) }
        Result.new(record:, entity: record.entity)
      end

      def delete!(entity)
        delete_related_records!(entity)
        delete_entity_record!(entity)
      end

      def delete_related_records!(_entity); end

      def delete_entity_record!(entity)
        connected_record(entity).delete
      end

      def connected_record(entity)
        find_by(serialize_entity_identifiers(entity))
      end

      def entity_properties_class
        entity_class::Properties
      end

      def seek(public_id)
        find_by(public_id:)&.entity
      end

      private

      def handle_database_errors
        yield
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
        save_entity_record!(entity).tap do
          save_related_records!(entity)
        end
      end

      def save_properties!(properties)
        create!(serialize_properties(properties))
      end

      def save_entity_record!(entity)
        record = connected_record(entity)
        if record.nil?
          create!(
            **serialize_properties(entity.properties),
            **serialize_entity_identifiers(entity)
          )
        else
          record.update!(serialize_properties(entity.properties))
          record
        end
      end

      def save_related_records!(_entity); end

      def serialize_entity_identifiers(entity)
        { id: entity.private_id, public_id: entity.public_id }
      end

      def serialize_properties(properties)
        properties.as_json
      end
    end
  end
end
