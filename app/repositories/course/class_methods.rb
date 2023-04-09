# frozen_string_literal: true

module Repositories
  class Course
    module ClassMethods
      def serialize_property_attributes_with_different_names(properties)
        { author: Talent.connected_record(properties.author) }
      end

      def handle_database_errors
        yield
      rescue ActiveRecord::RecordNotUnique
        raise NameDuplicationError
      end
    end
  end
end
