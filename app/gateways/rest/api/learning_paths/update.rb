# frozen_string_literal: true

module REST
  class API
    class LearningPaths
      class Update < Base
        class Contract < Dry::Validation::Contract
          json do
            required(:name).filled(Types::Name)
            required(:course_ids).value(Types::Array.of(Types::ID::Public).constrained(min_size: 1))
          end
        end

        desc "Update a learning_path content"
        put do
          learning_path = find_requested_learning_path!
          validate!(params, with: Contract)
            .then { |validated| ::LearningPath::Update.new.call(learning_path:, params: validated) }
            .then { |entity| present entity, with: Serialization::LearningPath }
        rescue ::LearningPath::NameDuplicationError
          validation_error!(:name, I18n.t("rest.errors.already_taken"))
        rescue ::Types::LearningPath::NotPublishedCoursesError => error
          course_ids = error.courses.map(&:public_id).join(",")
          validation_error!(:course_ids, I18n.t("rest.learning_paths.errors.not_published_courses", course_ids:))
        rescue ::BaseService::NotFoundError => error
          validation_error!(error.key, error.message)
        rescue ::Types::Course::AlreadyPublishedError
          validation_error!(:name,
                            I18n.t("rest.learning_materials.errors.already_published", material: "learning path"))
        end
      end
    end
  end
end
