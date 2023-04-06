# frozen_string_literal: true

module REST
  module Validation
    module Talent
      class Properties < Dry::Validation::Contract
        json do
          required(:first_name).filled(Types::Name)
          required(:last_name).filled(Types::Name)
          required(:email).filled(Types::Email)
        end
      end
    end
  end
end
