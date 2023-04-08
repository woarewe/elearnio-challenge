# frozen_string_literal: true

module Types
  class Course
    class Properties < Struct
      attribute :name, Name
      attribute :author, Talent
      attribute :status, LearningMaterial::Status.enum
      attribute :content, String
    end
  end
end
