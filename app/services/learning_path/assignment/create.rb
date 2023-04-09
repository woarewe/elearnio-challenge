# frozen_string_literal: true

module Services
  module LearningPath
    module Assignment
      class Create < Services::Base
        def call(params)
          talent = find_talent!(params, as: :talent_id)
          find_learning_path!(params)
            .then { |course| build_properties(talent, course) }
            .then { |properties| Repositories::LearningPath::Assignment.save!(properties) }
            .then(&:entity)
        end

        private

        def find_learning_path!(params)
          params => { learning_path_id: }
          ::Repositories::LearningPath.seek(learning_path_id).tap do |learning_path|
            raise NotFoundError, :learning_path if learning_path.nil?
          end
        end

        def build_properties(talent, learning_path)
          ::Types::LearningPath::Assignment::Properties.new(talent:, learning_path:)
        end
      end
    end
  end
end
