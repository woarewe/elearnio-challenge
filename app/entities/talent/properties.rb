# frozen_string_literal: true

module Types
  class Talent
    class Properties < Struct
      attribute :first_name, Name
      attribute :last_name, Name
      attribute :email, Email
    end
  end
end
