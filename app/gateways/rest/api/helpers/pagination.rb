# frozen_string_literal: true

module REST
  class API
    module Helpers
      module Pagination
        include Validation

        def pagination_params!(params)
          validated = validate!(params, with: ::REST::Validation::Pagination)
          default_pagination_params.merge(validated).symbolize_keys
        end

        def default_pagination_params
          {
            page: 1,
            per_page: PER_PAGE_DEFAULT
          }.with_indifferent_access
        end

        def present_paginated(collection, with:, page:, per_page:)
          paginated = collection.page(page).per(per_page).sequentially
          {
            items: paginated.map { |item| with.new(item.entity).serializable_hash },
            last_page: paginated.total_pages
          }
        end
      end
    end
  end
end
