# frozen_string_literal: true

module REST
  module Serialization
    class Timestamps < Base
      expose :created_at, format_with: :iso_timestamp
      expose :updated_at, format_with: :iso_timestamp
    end
  end
end
