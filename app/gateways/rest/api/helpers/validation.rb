# frozen_string_literal: true

module REST
  class API
    module Helpers
      module Validation
        def validate!(params, with: nil)
          contract = with.new
          result = contract.call(params)
          error!(result.errors.to_h, 422) if result.failure? # rubocop:disable Rails/DeprecatedActiveModelErrorsMethods

          result.to_h.with_indifferent_access
        end

        def validation_error!(field, message)
          errors = { field => Array(message) }
          error!(errors, 422)
        end

        def not_found!(key)
          errors = { key => Array(I18n.t!("rest.errors.not_found")) }
          error!(errors, 404)
        end
      end
    end
  end
end
