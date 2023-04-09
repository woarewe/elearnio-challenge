# frozen_string_literal: true

module REST
  class API
    module Helpers
      module LearningPaths
        def handle_execution_errors # rubocop:disable Metrics/MethodLength
          yield
        rescue ::Repositories::LearningPath::NameDuplicationError
          validation_error!(:name, I18n.t("rest.errors.already_taken"))
        rescue ::Types::LearningPath::NotPublishedCoursesError => error
          course_ids = error.courses.map(&:public_id).join(",")
          validation_error!(:course_ids, I18n.t("rest.learning_paths.errors.not_published_courses", course_ids:))
        rescue ::Services::NotFoundError => error
          validation_error!(error.key, error.message)
        rescue ::Types::Course::AlreadyPublishedError
          validation_error!(
            :id,
            I18n.t("rest.learning_materials.errors.already_published", material: "learning path")
          )
        end

        def find_requested_resource!(includes = {})
          params => { id: public_id }
          ::Repositories::LearningPath
            .includes(includes)
            .seek(public_id)
            .tap { |resource| not_found!(:id) if resource.nil? }
        end
      end
    end
  end
end
