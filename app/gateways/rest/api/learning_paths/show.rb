# frozen_string_literal: true

module REST
  class API
    class LearningPaths
      class Show < Base
        desc "Show a learning_path"
        get do
          find_requested_learning_path!
            .then { |entity| present entity, with: Serialization::LearningPath }
        end
      end
    end
  end
end
