# frozen_string_literal: true

class LearningPath
  class Create < BaseService
    def call(params)
      author = find_author!(params)
      courses = find_courses!(params)
      status = ::Types::LearningMaterial::Status::DRAFT
      properties = ::Types::LearningPath::Properties.new(params.merge(author:, courses:, status:))
      LearningPath.save!(properties)
    end

    private

    def find_author!(params)
      params => { author_id: public_id }
      ::Talent
        .find_by_public_id(public_id)
        .tap { |talent| raise NotFoundError, :id if talent.nil? }
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
