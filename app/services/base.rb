# frozen_string_literal: true

module Services
  class Base
    private

    def transaction(&)
      ActiveRecord::Base.transaction(&)
    end
  end
end
