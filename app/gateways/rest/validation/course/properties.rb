# frozen_string_literal: true

module REST
  module Validation
    module Course
      class Properties < Dry::Validation::Contract
        json do
          required(:name).filled(Types::Name)
          required(:content).filled(Types::String)
          required(:author_id).filled(Types::ID::Public)
        end
      end
    end
  end
end
