# frozen_string_literal: true

module Tests
  module Helpers
    module Repositories
      module Course
        module_function

        def persist_course!(entity)
          ::Repositories::Course.find_or_create_by!(
            id: entity.private_id,
            public_id: entity.public_id,
            name: entity.name,
            status: entity.status,
            content: entity.content,
            created_at: entity.timestamps.created_at,
            updated_at: entity.timestamps.updated_at,
            author: Talent.persist_talent!(entity.author)
          )
        end
      end
    end
  end
end
