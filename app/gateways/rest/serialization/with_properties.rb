# frozen_string_literal: true

module REST
  module Serialization
    module WithProperties
      extend ActiveSupport::Concern

      included do
        expose :properties do |object, _|
          object.properties.as_json
        end
      end
    end
  end
end
