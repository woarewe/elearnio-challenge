# frozen_string_literal: true

module REST
  class API
    class Talents
      class AssignedLearningPaths < Base
        desc "Show learning paths assigned to a talent"
        get :assigned_learning_paths do
          pagination = pagination_params!(params)
          talent = find_requested_resource!
          ::Repositories::LearningPath::Assignment
            .includes(:talent, learning_path: [:author, { courses: :author }])
            .where(talent_id: talent.private_id)
            .then { |items| present_paginated(items, **pagination, with: Serialization::LearningPath::Assignment) }
        end
      end
    end
  end
end
