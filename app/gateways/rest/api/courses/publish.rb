# frozen_string_literal: true

module REST
  class API
    class Courses
      class Publish < Base
        desc "Publish a course"
        patch :publish do
          course = find_requested_course!
          course
            .publish!
            .then { |entity| ::Course.save!(entity) }
            .then { |entity| present entity, with: Serialization::Course }
        rescue ::Types::Course::AlreadyPublishedError
          validation_error!(:name, I18n.t("rest.courses.errors.already_published"))
        end
      end
    end
  end
end
