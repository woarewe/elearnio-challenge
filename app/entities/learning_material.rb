# frozen_string_literal: true

module Types
  module LearningMaterial
    extend ActiveSupport::Concern

    Error = Class.new(StandardError)
    AlreadyPublishedError = Class.new(Error)

    def published?
      properties.status == LearningMaterial::Status::PUBLISHED
    end

    def draft?
      properties.status == LearningMaterial::Status::DRAFT
    end

    def author?(talent)
      properties.author == talent
    end

    def publish!
      published_guard! { update_properties(status: LearningMaterial::Status::PUBLISHED) }
    end

    def update_author(author)
      update_properties(author:)
    end

    def update_name!(name)
      published_guard! { update_properties(name:) }
    end

    private

    def published_guard!
      raise AlreadyPublishedError if published?

      yield
    end
  end
end
