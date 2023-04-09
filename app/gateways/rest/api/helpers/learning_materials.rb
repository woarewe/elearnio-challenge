# frozen_string_literal: true

module REST
  class API
    module Helpers
      module LearningMaterials
        def apply_filters(filters, relation)
          result = relation
          result = result.filter_by_author_public_ids(filters.fetch(:author_ids)) if filters.key?(:author_ids)
          result = result.filter_by_name(filters.fetch(:name)) if filters.key?(:name)
          result = result.filter_by_statuses(filters.fetch(:statuses)) if filters.key?(:statuses)
          result
        end
      end
    end
  end
end
