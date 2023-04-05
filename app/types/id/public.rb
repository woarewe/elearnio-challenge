# frozen_string_literal: true

module Types
  module ID
    Public = Types::String.constrained(min_size: 1)
  end
end
