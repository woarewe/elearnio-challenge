# frozen_string_literal: true

module REST
  class API
    class Courses
      class Delete < Base
        desc "Delete a course"
        delete do
          status 204
          course = find_requested_resource!
          if course.published?
            invalid!(:id, I18n.t!("rest.learning_materials.errors.deleting_published", material: "course"))
          end
          ::Repositories::Course.delete!(course)
        end
      end
    end
  end
end
