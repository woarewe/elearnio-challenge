# frozen_string_literal: true

module REST
  module Serialization
    module WithPublicID
      extend ActiveSupport::Concern

      included do
        expose :id do |object, _options|
          object.public_id
        end
      end
    end
  end
end
