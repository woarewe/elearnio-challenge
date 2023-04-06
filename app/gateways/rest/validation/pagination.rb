# frozen_string_literal: true

module REST
  module Validation
    class Pagination < Dry::Validation::Contract
      params do
        optional(:page).filled(:integer, gteq?: 1)
        optional(:per_page).filled(:integer, gteq?: 1, lteq?: REST::API::PER_PAGE_LIMIT)
      end
    end
  end
end
