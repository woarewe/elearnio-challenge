# frozen_string_literal: true

module Repositories
  class Course
    class Assignment < Base
      entity Types::Course::Assignment

      belongs_to :course
      belongs_to :talent

      Error = Class.new(Error)
      AlreadyAssignedError = Class.new(Error)

      class << self
        def serialize_property_attributes_with_different_names(properties)
          {
            talent: Talent.connected_record(properties.talent),
            course: Course.connected_record(properties.course)
          }
        end

        def handle_database_errors
          yield
        rescue ActiveRecord::RecordNotUnique
          raise AlreadyAssignedError
        end
      end

      def override_entity_attributes
        { talent: talent.entity, course: course.entity }
      end
    end
  end
end
