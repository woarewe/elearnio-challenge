# frozen_string_literal: true

module REST
  class API
    class Courses
      class Update < Base
        class Contract < Dry::Validation::Contract
          json do
            required(:name).filled(Types::Name)
            required(:content).filled(Types::String)
          end
        end

        desc "Update a course content"
        put do
          course = find_requested_course!
          validate!(params, with: Contract) => { name:, content: }
          course
            .update_content!(content)
            .update_name!(name)
            .then { |entity| ::Course.save!(entity) }
            .then { |entity| present entity, with: Serialization::Course }
        rescue ::Course::NameDuplicationError
          validation_error!(:name, I18n.t("rest.errors.already_taken"))
        rescue ::Types::Course::AlreadyPublishedError
          validation_error!(:name, I18n.t("rest.courses.errors.already_published"))
        end
      end
    end
  end
end
