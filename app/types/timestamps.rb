# frozen_string_literal: true

module Types
  class Timestamps < Dry::Struct
    attribute :created_at, DateTime
    attribute :updated_at, DateTime
  end
end
