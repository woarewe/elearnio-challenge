# frozen_string_literal: true

module Tests
  module Helpers
    module Repositories
      module Talent
        module_function

        def persist_talent!(entity)
          ::Repositories::Talent.find_or_create_by!(
            id: entity.private_id,
            public_id: entity.public_id,
            first_name: entity.first_name,
            last_name: entity.last_name,
            email: entity.email,
            created_at: entity.timestamps.created_at,
            updated_at: entity.timestamps.updated_at
          )
        end
      end
    end
  end
end
