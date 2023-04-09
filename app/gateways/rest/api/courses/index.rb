# frozen_string_literal: true

module REST
  class API
    class Courses
      class Index < Base
        desc "Show courses"
        get do
          pagination = pagination_params!(params)
          validate!(params, with: Validation::LearningMaterial::Filter)
            .then { |filters| apply_filters(filters, ::Repositories::Course.includes(:author)) }
            .then { |filtered| present_paginated(filtered, **pagination, with: Serialization::Course) }
        end
      end
    end
  end
end
