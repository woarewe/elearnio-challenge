# frozen_string_literal: true

class Talent < ApplicationRecord
  include Repository

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
