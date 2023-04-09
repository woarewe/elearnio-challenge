# frozen_string_literal: true

module REST
  class API
    module Helpers
      module Courses
        def handle_execution_errors
          yield
        rescue ::Repositories::Course::NameDuplicationError
          validation_error!(:name, I18n.t("rest.errors.already_taken"))
        rescue ::Services::NotFoundError => error
          validation_error!(error.key, error.message)
        rescue ::Types::Course::AlreadyPublishedError
          validation_error!(:name, I18n.t!("rest.learning_materials.errors.already_published", material: "course"))
        end

        def find_requested_resource!(includes = {})
          params => { id: public_id }
          ::Repositories::Course
            .includes(includes)
            .seek(public_id)
            .tap { |resource| not_found!(:id) if resource.nil? }
        end
      end
    end
  end
end
