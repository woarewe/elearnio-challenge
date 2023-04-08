# frozen_string_literal: true

class Talent < ApplicationRecord
  include Repository

  entity Types::Talent

  Error = Class.new(Error)
  EmailDuplicationError = Class.new(Error)

  has_many :created_courses, class_name: "Course", dependent: nil, inverse_of: :author

  class << self
    def handle_database_errors
      yield
    rescue ActiveRecord::RecordNotUnique
      raise EmailDuplicationError
    end
  end
end
