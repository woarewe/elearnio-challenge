# frozen_string_literal: true

module Services
  module Course
    module Assignment
      class Complete < Services::Base
        def call(assignment)
          assignment
            .complete!
            .then { |entity| Repositories::Course::Assignment.save!(entity) }
            .then(&:entity)
        end
      end
    end
  end
end
