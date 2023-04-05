# frozen_string_literal: true

module Types
  module ID
    Private = Types::Integer.constrained(gt: 0)
  end
end
