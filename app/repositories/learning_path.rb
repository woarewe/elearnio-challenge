# frozen_string_literal: true

module Repositories
  class LearningPath < Base
    include LearningMaterial

    entity Types::LearningPath

    Error = Class.new(StandardError)
    NameDuplicationError = Class.new(Error)

    has_many :slots, -> { positioned }, class_name: "Slot", dependent: nil, inverse_of: :learning_path
    has_many :courses, through: :slots

    belongs_to :author, class_name: "Talent"

    class << self
      def serialize_property_attributes_with_different_names(properties)
        { author: Talent.connected_record(properties.author) }
      end

      def save_related_records!(entity, record)
        ::Repositories::LearningPath::Slot.where(learning_path: record).delete_all
        # TODO: Use upsert here
        entity.courses.each_with_index do |course, index|
          record.slots.create!(position: index + 1, course_id: course.private_id)
        end
      end

      def handle_database_errors
        yield
      rescue ActiveRecord::RecordNotUnique
        raise NameDuplicationError
      end

      def delete!(entity)
        transaction do
          ::Repositories::LearningPath::Slot.where(learning_path_id: entity.private_id).delete_all
          delete(entity.private_id)
        end
      end
    end

    def override_entity_attributes
      { author: author.entity, courses: courses.map(&:entity) }
    end
  end
end
