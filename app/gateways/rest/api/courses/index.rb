# frozen_string_literal: true

module REST
  class API
    class Courses
      class Index < Base
        class Filter < Dry::Validation::Contract
          params do
            optional(:author_ids).array(::Types::ID::Public)
            optional(:name).filled(::Types::Name)
            optional(:statuses).array(::Types::Course::Status.enum)
          end
        end

        helpers do
          def apply_filters(filters)
            result = ::Course.includes(:author)
            result = result.filter_by_author_public_ids(filters.fetch(:author_ids)) if filters.key?(:author_ids)
            result = result.filter_by_name(filters.fetch(:name)) if filters.key?(:name)
            result = result.filter_by_statuses(filters.fetch(:statuses)) if filters.key?(:statuses)
            result
          end
        end

        desc "Show courses"
        get do
          pagination = pagination_params!(params)
          validate!(params, with: Filter)
            .then { |filters| apply_filters(filters) }
            .then { |filtered| present_paginated(filtered, **pagination, with: Serialization::Course) }
        end
      end
    end
  end
end
