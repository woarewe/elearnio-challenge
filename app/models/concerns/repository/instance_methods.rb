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

    def entity_properties
      self.class.property_class.new(entity_properties_hash)
    end

    def entity_properties_hash
      as_json.with_indifferent_access.slice(*self.class.property_class.attribute_names)
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
