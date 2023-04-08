# frozen_string_literal: true

module Types
  module Entity
    extend ActiveSupport::Concern

    included do |target|
      attribute :private_id, ID::Private
      attribute :public_id, ID::Public
      attribute :timestamps, Timestamps
      attribute :properties, target::Properties

      target::Properties.attribute_names.each do |attribute_name|
        define_method(attribute_name) { properties.send(attribute_name) }
      end
    end

    def eql?(other)
      public_id.eql?(other.public_id) && super
    end

    def update_properties(properties)
      new(to_h.merge(properties:))
    end
  end
end
