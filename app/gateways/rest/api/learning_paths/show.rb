# frozen_string_literal: true

module REST
  class API
    class LearningPaths
      class Show < Base
        desc "Show a learning_path"
        get do
          find_requested_resource!([:author, { courses: :author }])
            .then { |entity| present entity, with: Serialization::LearningPath }
        end
      end
    end
  end
end
