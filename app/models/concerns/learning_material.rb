# frozen_string_literal: true

module LearningMaterial
  extend ActiveSupport::Concern

  included do
    scope :filter_by_author_public_ids, ->(ids) { joins(:author).where(author: { public_id: ids }) }
    scope :filter_by_name, ->(name) { where("name ILIKE :name", name: "%#{name}%") }
    scope :filter_by_statuses, ->(statuses) { where(status: statuses) }
    scope :filter_by_author, ->(author) { where(author_id: author.private_id) }
    scope :with_author, -> { includes(:author) }
  end
end
