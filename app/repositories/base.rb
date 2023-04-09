# frozen_string_literal: true

module Repositories
  Error = Class.new(StandardError)

  class Base < ActiveRecord::Base
    self.abstract_class = true

    scope :sequentially, -> { order(created_at: :asc) }

    class << self
      def entity(entity_class)
        @entity_class = entity_class

        extend ClassMethods

        include InstanceMethods
        include PublicID
      end

      attr_reader :entity_class
    end
  end
end
