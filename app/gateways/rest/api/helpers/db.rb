# frozen_string_literal: true

module REST
  class API
    module Helpers
      module DB
        def transaction(&)
          ActiveRecord::Base.transaction(&)
        end
      end
    end
  end
end
