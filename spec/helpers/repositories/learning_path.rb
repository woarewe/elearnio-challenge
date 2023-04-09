# frozen_string_literal: true

module Tests
  module Helpers
    module Repositories
      module LearningPath
        module_function

        def persist_learning_path!(entity)
          learning_path = ::Repositories::LearningPath.find_or_create_by!(
            id: entity.private_id,
            public_id: entity.public_id,
            name: entity.name,
            status: entity.status,
            created_at: entity.timestamps.created_at,
            updated_at: entity.timestamps.updated_at,
            author: Talent.persist_talent!(entity.author)
          )
          entity.courses.each_with_index do |course, index|
            record = Course.persist_course!(course)
            learning_path.slots.find_or_create_by!(course: record, position: index)
          end
          learning_path
        end
      end
    end
  end
end
