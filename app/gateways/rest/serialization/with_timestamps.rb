# frozen_string_literal: true

module REST
  module Serialization
    module WithTimestamps
      extend ActiveSupport::Concern

      included do
        expose :timestamps, using: Timestamps
      end
    end
  end
end
