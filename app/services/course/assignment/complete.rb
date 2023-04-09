# frozen_string_literal: true

module Services
  module Course
    module Assignment
      class Complete < Services::Base
        def call(assignment)
          transaction do
            complete_assignment(assignment).tap { |completed| assign_next_from_learning_paths(completed.talent) }
          end
        end

        private

        def complete_assignment(assignment)
          assignment
            .complete!
            .then { |entity| Repositories::Course::Assignment.save!(entity) }
            .then(&:entity)
        end

        def assign_next_from_learning_paths(talent)
          ::Repositories::LearningPath
            .assigned_to(talent).map(&:entity)
            .each { |learning_path| LearningPath::AssignNextCourse.new.call(learning_path:, talent:) }
        end
      end
    end
  end
end
