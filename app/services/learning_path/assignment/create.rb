# frozen_string_literal: true

module Services
  module LearningPath
    module Assignment
      class Create < Services::Base
        dependency :assign_next_course, default: -> { Services::LearningPath::AssignNextCourse.new }

        def call(params)
          talent = find_talent!(params, as: :talent_id)
          learning_path = find_learning_path!(params)
          create_assignment!(talent:, learning_path:)
            .tap { assign_next_course.call(learning_path:, talent:) }
        end

        private

        def create_assignment!(talent:, learning_path:)
          build_properties(talent:, learning_path:)
            .then { |properties| Repositories::LearningPath::Assignment.save!(properties) }
            .then(&:entity)
        end

        def find_learning_path!(params)
          params => { learning_path_id: }
          ::Repositories::LearningPath.seek(learning_path_id).tap do |learning_path|
            raise NotFoundError, :learning_path_id if learning_path.nil?
          end
        end

        def build_properties(talent:, learning_path:)
          ::Types::LearningPath::Assignment::Properties.new(talent:, learning_path:)
        end
      end
    end
  end
end
