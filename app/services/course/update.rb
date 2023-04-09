# frozen_string_literal: true

module Services
  module Course
    class Update < Base
      def call(course:, params:)
        find_author!(params)
          .then { |author| update_attributes(course, params, author) }
          .then { |entity| ::Repositories::Course.save!(entity) }
          .then(&:entity)
      end

      private

      def update_attributes(course, params, author)
        params => { content:, name: }
        course
          .update_author(author)
          .update_content!(content)
          .update_name!(name)
      end
    end
  end
end
