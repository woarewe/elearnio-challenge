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
      updated_properties = Properties.new(properties.to_h.merge(content:))
      update_properties(updated_properties)
    end
  end
end
