# frozen_string_literal: true

module REST
  class API
    class Talents
      class AssignedCourses < Base
        desc "Show courses assigned to a talent"
        get :assigned_courses do
          pagination = pagination_params!(params)
          talent = find_requested_resource!
          ::Repositories::Course::Assignment
            .includes(:talent, course: :author)
            .where(talent_id: talent.private_id)
            .then { |items| present_paginated(items, **pagination, with: Serialization::Course::Assignment) }
        end
      end
    end
  end
end
