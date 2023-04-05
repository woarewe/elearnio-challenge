# frozen_string_literal: true

module Tests
  module Helpers
    def silence_errors
      yield
    rescue StandardError
      nil
    end
  end
end

require_relative "helpers/services"
