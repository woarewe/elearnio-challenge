# frozen_string_literal: true

module Services
  class NotFoundError < Error
    attr_reader :key, :ids

    def initialize(key, ids = [])
      @ids = ids
      @key = key
      super message
    end

    def message
      @message ||= [
        I18n.t!("services.errors.not_found"),
        ids.presence
      ].compact.join(" ")
    end
  end
end
