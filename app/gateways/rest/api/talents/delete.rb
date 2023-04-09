# frozen_string_literal: true

module REST
  class API
    class Talents
      class Delete < Base
        desc "Delete a talent"
        delete do
          status 204
          talent = find_requested_resource!
          Services::Talent::Delete.new.call(talent:, params:)
        rescue Services::Talent::Delete::NoNewAuthorProvidedError
          validation_error!(:new_author_id, I18n.t("rest.talents.errors.no_new_author"))
        rescue ::Services::NotFoundError => error
          validation_error!(error.key, error.message)
        rescue ::Services::Talent::Delete::NewAuthorAssignedToMaterialError
          validation_error!(:new_author_id, I18n.t("rest.talents.errors.new_author_assigned"))
        end
      end
    end
  end
end
