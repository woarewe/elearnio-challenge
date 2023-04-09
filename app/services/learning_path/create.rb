# frozen_string_literal: true

module Services
  module LearningPath
    class Create < Base
      def call(params)
        author = find_author!(params)
        courses = find_courses!(params)
        properties = build_properties(params, author, courses)
        Repositories::LearningPath.save!(properties).entity
      end

      private

      def build_properties(params, author, courses)
        params => { name: }
        ::Types::LearningPath::Properties.new(author:, courses:, status: initial_status, name:)
      end

      def initial_status
        ::Types::LearningMaterial::Status::DRAFT
      end
    end
  end
end
