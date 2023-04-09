# frozen_string_literal: true

module Services
  module LearningPath
    class Base < Services::Base
      private

      def find_author!(params)
        params => { author_id: public_id }
        ::Repositories::Talent
          .seek(public_id)
          .tap { |talent| raise NotFoundError, :author_id if talent.nil? }
      end

      def find_courses!(params)
        params => { course_ids: public_ids }
        courses = ::Repositories::Course.with_author.where(public_id: public_ids).map(&:entity)
        not_found = Set.new(public_ids) - Set.new(courses.map(&:public_id))
        raise NotFoundError.new(:course_ids, not_found.to_a) if not_found.any?

        courses
      end
    end
  end
end
