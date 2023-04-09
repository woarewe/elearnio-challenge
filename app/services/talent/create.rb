# frozen_string_literal: true

module Services
  module Talent
    class Create
      def call(params)
        properties = ::Types::Talent::Properties.new(params)
        ::Repositories::Talent.save!(properties).entity
      end
    end
  end
end
