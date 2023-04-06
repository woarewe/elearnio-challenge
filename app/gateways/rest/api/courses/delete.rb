# frozen_string_literal: true

module REST
  class API
    class Courses
      class Delete < Base
        desc "Delete a course"
        delete do
          status 204
          course = find_requested_course!
          invalid!(:id, I18n.t!("rest.courses.errors.deleting_published")) if course.published?
          ::Course.delete(course.private_id)
        end
      end
    end
  end
end
