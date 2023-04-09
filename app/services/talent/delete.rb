# frozen_string_literal: true

module Services
  module Talent
    class Delete < Base
      Error = Class.new(Error)
      NoNewAuthorProvidedError = Class.new(Error)
      NewAuthorAssignedToMaterialError = Class.new(Error)
      SameTalentError = Class.new(Error)

      def call(talent:, params:)
        transaction do
          move_ownership!(talent:, params:) if author?(talent)
          delete_progress!(talent)
          ::Repositories::Talent.delete!(talent)
        end
      end

      private

      def author?(talent)
        ::Repositories::Talent.author?(talent)
      end

      def move_ownership!(talent:, params:)
        new_author = find_new_author!(params)
        raise SameTalentError if new_author == talent

        move_courses_ownership!(talent:, new_author:)
        move_learning_paths_ownership!(talent:, new_author:)
      end

      def move_courses_ownership!(talent:, new_author:)
        courses = ::Repositories::Course.filter_by_author(talent)
        ensure_no_course_assignments!(new_author:, courses:)
        courses.each do |course|
          Repositories::Course.save!(course.entity.update_author(new_author))
        end
      end

      def ensure_no_course_assignments!(courses:, new_author:)
        return if ::Repositories::Course::Assignment.where(courses:, talent_id: new_author.private_id).blank?

        raise NewAuthorAssignedToMaterialError
      end

      def move_learning_paths_ownership!(talent:, new_author:)
        learning_paths = ::Repositories::LearningPath.filter_by_author(talent)
        ensure_no_learning_path_assignments!(new_author:, learning_paths:)
        learning_paths.each do |learning_path|
          Repositories::LearningPath.save!(learning_path.entity.update_author(new_author))
        end
      end

      def ensure_no_learning_path_assignments!(learning_paths:, new_author:)
        return if ::Repositories::LearningPath::Assignment.where(learning_paths:, talent: new_author.private_id).blank?

        raise NewAuthorAssignedToMaterialError
      end

      def find_new_author!(params)
        public_id = params[:new_author_id]
        raise NoNewAuthorProvidedError if public_id.blank?

        find_talent!(params, as: :new_author_id)
      end

      def delete_progress!(talent)
        ::Repositories::Course::Assignment.where(talent: talent.private_id).delete_all
        ::Repositories::LearningPath::Assignment.where(talent: talent.private_id).delete_all
      end
    end
  end
end
