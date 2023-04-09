# frozen_string_literal: true

module Types
  class Course < Struct
    include Entity
    include LearningMaterial

    Error = Class.new(StandardError)

    def update_content!(content)
      published_guard! { update_content(content) }
    end

    private

    def update_content(content)
      update_properties(content:)
    end
  end
end
