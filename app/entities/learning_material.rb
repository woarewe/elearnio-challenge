# frozen_string_literal: true

module Types
  module LearningMaterial
    extend ActiveSupport::Concern

    Error = Class.new(StandardError)
    AlreadyPublishedError = Class.new(Error)
    SameAuthorError = Class.new(Error)

    included do
      private :update_properties
    end

    def published?
      properties.status == LearningMaterial::Status::PUBLISHED
    end

    def draft?
      properties.status == LearningMaterial::Status::DRAFT
    end

    def publish!
      published_guard! { update_status(LearningMaterial::Status::PUBLISHED) }
    end

    def change_author!(author)
      raise SameAuthorError if author == properties.author

      update_author(author)
    end

    def update_name!(name)
      published_guard! { update_name(name) }
    end

    private

    def published_guard!
      raise AlreadyPublishedError if published?

      yield
    end

    def update_name(name)
      updated_properties = self.class::Properties.new(properties.to_h.merge(name:))
      update_properties(updated_properties)
    end

    def update_author(author)
      updated_properties = self.class::Properties.new(properties.to_h.merge(author:))
      update_properties(updated_properties)
    end

    def update_status(status)
      updated_properties = self.class::Properties.new(properties.to_h.merge(status:))
      update_properties(updated_properties)
    end
  end
end
