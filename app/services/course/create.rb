# frozen_string_literal: true

module Services
  module Course
    class Create < Base
      def call(params)
        find_author!(params)
          .then { |author| build_properties(params, author) }
          .then { |properties| ::Repositories::Course.save!(properties) }
          .then(&:entity)
      end

      private

      def initial_status
        ::Types::LearningMaterial::Status::DRAFT
      end

      def find_author!(params)
        params => { author_id: }
        ::Repositories::Talent.seek(author_id).tap do |author|
          raise NotFoundError, :author_id if author.nil?
        end
      end

      def build_properties(params, author)
        params => { name:, content: }
        ::Types::Course::Properties.new(content:, name:, author:, status: initial_status)
      end
    end
  end
end
