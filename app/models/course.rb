# frozen_string_literal: true

class Course < ApplicationRecord
  include Repository
  include LearningMaterial

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

  def custom_entity_properties_hash
    { author: author.entity }
  end
end
