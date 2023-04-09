# frozen_string_literal: true

module Repositories
  module PublicID
    extend ActiveSupport::Concern

    included do
      after_create :reload_public_id
    end

    def initialize_copy(_other)
      super

      self[:public_id] = nil
    end

    def reload_public_id
      self[:public_id] = self.class.unscoped.where(id:).pick(:public_id)
    end
  end
end
