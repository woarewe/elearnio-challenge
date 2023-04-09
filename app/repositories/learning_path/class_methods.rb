# frozen_string_literal: true

module Repositories
  class LearningPath
    module ClassMethods
      def delete!(entity)
        transaction do
          ::Repositories::LearningPath::Slot.where(learning_path_id: entity.private_id).delete_all
          delete(entity.private_id)
        end
      end

      def assigned_to(talent)
        joins(:assignments).where(assignments: { talent_id: talent.private_id })
      end

      private

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
    end
  end
end
