# frozen_string_literal: true

module Repository
  extend ActiveSupport::Concern

  Error = Class.new(StandardError)

  included do
    extend ClassMethods

    include InstanceMethods
    include PublicID

    scope :sequentially, -> { order(created_at: :asc) }
  end
end
