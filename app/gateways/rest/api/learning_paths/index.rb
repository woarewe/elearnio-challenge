# frozen_string_literal: true

module REST
  class API
    class LearningPaths
      class Index < Base
        desc "Show learning_paths"
        get do
          pagination = pagination_params!(params)
          relation = ::Repositories::LearningPath.includes([:author, { courses: :author }])
          validate!(params, with: Validation::LearningMaterial::Filter)
            .then { |filters| apply_filters(filters, relation) }
            .then { |filtered| present_paginated(filtered, **pagination, with: Serialization::LearningPath) }
        end
      end
    end
  end
end
