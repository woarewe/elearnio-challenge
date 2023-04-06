# frozen_string_literal: true

class LearningPath < ApplicationRecord
  include Repository
  include LearningMaterial

  entity Types::LearningPath

  Error = Class.new(StandardError)
  NameDuplicationError = Class.new(Error)

  has_many :slots, -> { positioned }, class_name: "Slot", dependent: nil, inverse_of: :learning_path
  has_many :courses, through: :slots

  belongs_to :author, class_name: "Talent"

  class << self
    def serialize_entity_properties_relations(properties)
      {
        author: Talent.connected_record(properties.author),
        slots: Course.connected_records(properties.courses).map.with_index do |record, index|
          Slot.new(course: record, position: index + 1)
        end
      }
    end

    def save_entity!(entity) # rubocop:disable  Metrics/MethodLength
      record = connected_record(entity)
      serialize_entity_properties(entity.properties) => { slots:, **attributes }
      transaction do
        record.update!(attributes)
        record.slots.destroy_all
        slots.each do |slot|
          slot.learning_path = record
          slot.save!
        end
      end
      record
    end

    def handle_database_errors
      yield
    rescue ActiveRecord::RecordNotUnique
      raise NameDuplicationError
    end

    def serialize_entity_properties(...)
      super.except(:courses)
    end
  end

  def custom_entity_properties_hash
    { author: author.entity, courses: courses.map(&:entity) }
  end
end
