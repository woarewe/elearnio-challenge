# frozen_string_literal: true

module Services
  module Course
    class Create < Base
      def call(params)
        find_talent!(params, as: :author_id)
          .then { |author| build_properties(params, author) }
          .then { |properties| ::Repositories::Course.save!(properties) }
          .then(&:entity)
      end

      private

      def initial_status
        ::Types::LearningMaterial::Status::DRAFT
      end

      def build_properties(params, author)
        params => { name:, content: }
        ::Types::Course::Properties.new(content:, name:, author:, status: initial_status)
      end
    end
  end
end
