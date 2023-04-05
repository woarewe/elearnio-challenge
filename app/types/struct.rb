# frozen_string_literal: true

module Types
  class Struct < Dry::Struct
    transform_keys(&:to_sym)
  end
end
