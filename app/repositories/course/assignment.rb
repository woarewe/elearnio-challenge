# frozen_string_literal: true

class Course
  class Assignment < ApplicationRecord
    include BetterRepository

    entity Types::Course::Assignment

    belongs_to :course, inverse_of: :assignments
    belongs_to :talent, inverse_of: :course_assignments
  end
end
