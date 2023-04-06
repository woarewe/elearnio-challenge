# frozen_string_literal: true

class Course < ApplicationRecord
  include Repository

  entity Types::Course

  Error = Class.new(Error)
  NameDuplicationError = Class.new(Error)

  class << self
    def serialize_entity_properties_relations(properties)
      { author: Talent.connected_record(properties.author) }
    end

    def handle_database_errors
      yield
    rescue ActiveRecord::RecordNotUnique
      raise NameDuplicationError
    end
  end

  belongs_to :author, class_name: "Talent", inverse_of: :created_courses

  scope :filter_by_author_public_ids, ->(ids) { joins(:author).where(author: { public_id: ids }) }
  scope :filter_by_name, ->(name) { where("name ILIKE :name", name: "%#{name}%") }
  scope :filter_by_statuses, ->(statuses) { where(status: statuses) }

  def custom_entity_properties_hash
    { author: author.entity }
  end
end
