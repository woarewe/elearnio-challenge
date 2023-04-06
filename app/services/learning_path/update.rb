# frozen_string_literal: true

class LearningPath
  class Update < BaseService
    def call(learning_path:, params:)
      courses = find_courses!(params)
      params => { name:, }
      learning_path
        .update_name!(name)
        .update_courses!(courses)
        .then { |entity| LearningPath.save!(entity) }
    end

    def find_courses!(params)
      params => { course_ids: public_ids }
      courses = ::Course.with_author.where(public_id: public_ids).map(&:entity)
      not_found = Set.new(public_ids) - Set.new(courses.map(&:public_id))
      raise NotFoundError.new(:course_ids, not_found.to_a) if not_found.any?

      courses
    end
  end
end
