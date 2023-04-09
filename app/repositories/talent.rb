# frozen_string_literal: true

module Repositories
  class Talent < Base
    entity Types::Talent

    Error = Class.new(Error)
    EmailDuplicationError = Class.new(Error)

    class << self
      def handle_database_errors
        yield
      rescue ActiveRecord::RecordNotUnique
        raise EmailDuplicationError
      end
    end
  end
end
