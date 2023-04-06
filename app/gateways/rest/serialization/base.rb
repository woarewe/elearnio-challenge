# frozen_string_literal: true

module REST
  module Serialization
    class Base < Grape::Entity
      format_with(:iso_timestamp, &:iso8601)
    end
  end
end
