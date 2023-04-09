# frozen_string_literal: true

module REST
  class API
    module Helpers
      module Talents
        def handle_execution_errors
          yield
        rescue ::Repositories::Talent::EmailDuplicationError
          validation_error!(:email, I18n.t("rest.errors.already_taken"))
        end

        def find_requested_talent!(includes = {})
          params => { id: public_id }
          ::Repositories::Talent
            .includes(includes)
            .seek(public_id)
            .tap { |talent| not_found!(:id) if talent.nil? }
        end
      end
    end
  end
end
