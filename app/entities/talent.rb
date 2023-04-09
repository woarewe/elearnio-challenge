# frozen_string_literal: true

module Types
  class Talent < Struct
    include Entity

    def update_first_name(first_name)
      update_properties(first_name:)
    end

    def update_last_name(last_name)
      update_properties(last_name:)
    end

    def update_email(email)
      update_properties(email:)
    end
  end
end
