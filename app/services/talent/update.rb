# frozen_string_literal: true

module Services
  module Talent
    class Update
      def call(talent:, params:)
        update_attributes(talent, params)
          .then { |entity| ::Repositories::Talent.save!(entity) }
          .then(&:entity)
      end

      private

      def update_attributes(talent, params)
        params => { email:, first_name:, last_name: }
        talent
          .update_first_name(first_name)
          .update_last_name(last_name)
          .update_email(email)
      end
    end
  end
end
