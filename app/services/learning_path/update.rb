# frozen_string_literal: true

module Services
  module LearningPath
    class Update < Base
      def call(learning_path:, params:)
        courses = find_courses!(params)
        author = find_author!(params)
        params => { name: }
        learning_path
          .update_name!(name)
          .update_author(author)
          .update_courses!(courses)
          .then { |entity| Repositories::LearningPath.save!(entity).entity }
      end
    end
  end
end
