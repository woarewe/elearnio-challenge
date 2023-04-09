# frozen_string_literal: true

module Tests
  module Helpers
    module Repositories
      module Course
        module Assignment
          module_function

          def persist_course_assignment!(entity)
            ::Repositories::Course::Assignment.create!(
              id: entity.private_id,
              public_id: entity.public_id,
              status: entity.status,
              created_at: entity.timestamps.created_at,
              updated_at: entity.timestamps.updated_at,
              talent: Talent.persist_talent!(entity.talent),
              course: Course.persist_course!(entity.course)
            )
          end
        end
      end
    end
  end
end
