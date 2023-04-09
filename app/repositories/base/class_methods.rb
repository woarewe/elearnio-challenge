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

      def connected_record!(entity)
        find_by!(serialize_entity_identifiers(entity))
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
        transaction do
          save_entity_record!(entity).tap do |record|
            save_related_records!(entity, record)
          end
        end
      end

      def save_properties!(properties)
        transaction do
          create!(serialize_properties(properties)).tap do |record|
            save_related_records!(properties, record)
          end
        end
      end

      def save_entity_record!(entity)
        record = connected_record!(entity)
        record.update!(serialize_properties(entity.properties))
        record
      end

      def save_related_records!(_entity, _record); end

      def serialize_entity_identifiers(entity)
        { id: entity.private_id, public_id: entity.public_id }
      end

      def serialize_properties(properties)
        {
          **serialize_name_alike_property_attributes(properties),
          **serialize_property_attributes_with_different_names(properties)
        }
      end

      def serialize_name_alike_property_attributes(properties)
        properties.as_json.slice(*column_names)
      end

      def serialize_property_attributes_with_different_names(_properties)
        {}
      end
    end
  end
end
