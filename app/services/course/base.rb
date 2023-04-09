# frozen_string_literal: true

module Services
  module Course
    class Base
      private

      def find_author!(params)
        params => { author_id: }
        ::Repositories::Talent.seek(author_id).tap do |author|
          raise NotFoundError, :author_id if author.nil?
        end
      end
    end
  end
end
