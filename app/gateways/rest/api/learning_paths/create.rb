# frozen_string_literal: true

module REST
  class API
    class LearningPaths
      class Create < Base
        class Contract < Dry::Validation::Contract
          json do
            required(:name).filled(Types::Name)
            required(:author_id).filled(Types::ID::Public)
            required(:course_ids).value(Types::Array.of(Types::ID::Public).constrained(min_size: 1))
          end
        end

        desc "Create a learning path"
        post do
          validate!(params, with: Contract)
            .then { |properties| LearningPath::Create.new.call(properties) }
            .then { |entity| present entity, with: Serialization::LearningPath }
        rescue ::LearningPath::NameDuplicationError
          validation_error!(:name, I18n.t("rest.errors.already_taken"))
        rescue ::Types::LearningPath::NotPublishedCoursesError => error
          course_ids = error.courses.map(&:public_id).join(",")
          validation_error!(:course_ids, I18n.t("rest.learning_paths.errors.not_published_courses", course_ids:))
        rescue ::BaseService::NotFoundError => error
          validation_error!(error.key, error.message)
        end
      end
    end
  end
end
