# frozen_string_literal: true

module Repositories
  class Talent < Base
    entity Types::Talent

    Error = Class.new(Error)
    EmailDuplicationError = Class.new(Error)

    has_many :created_courses, class_name: "Course", inverse_of: :author
    has_many :course_assignments, class_name: "Course::Assignment", inverse_of: :course

    class << self
      def handle_database_errors
        yield
      rescue ActiveRecord::RecordNotUnique
        raise EmailDuplicationError
      end
    end
  end
end
