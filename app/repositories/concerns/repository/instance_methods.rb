# frozen_string_literal: true

module Repository
  module InstanceMethods
    def entity
      self.class.entity_class.new(
        timestamps: entity_timestamps,
        public_id: Types::ID::Public[public_id],
        private_id: Types::ID::Private[id],
        properties: entity_properties
      )
    end

    private

    def entity_properties
      self.class.entity_properties_class.new(
        **entity_attributes.with_indifferent_access,
        **adjusted_entity_attributes.with_indifferent_access
      )
    end

    def entity_attributes
      as_json.with_indifferent_access.slice(*self.class.entity_properties_class.attribute_names)
    end

    def adjusted_entity_attributes
      {}
    end

    def entity_timestamps
      Types::Timestamps.new(
        created_at: utc_datetime(created_at),
        updated_at: utc_datetime(updated_at)
      )
    end

    def utc_datetime(time)
      time.utc.to_datetime
    end
  end
end
