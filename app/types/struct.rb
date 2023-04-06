# frozen_string_literal: true

module Types
  class Struct < Dry::Struct
    transform_keys(&:to_sym)

    def initialize(...)
      super
      additional_checks!(...)
    end

    private

    def additional_checks!(*); end
  end
end
