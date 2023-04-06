# frozen_string_literal: true

module REST
  class API
    class Base < Grape::API
      format "json"
    end
  end
end
