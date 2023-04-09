# frozen_string_literal: true

module Services
  class Base
    extend Dry::Initializer

    class << self
      def dependency(name, type = nil, **opts, &)
        option(name, type, **opts.merge(reader: :private), &)
      end
    end

    private

    def find_talent!(params, as:)
      ::Repositories::Talent.seek(params.fetch(as)).tap do |entity|
        raise NotFoundError, as if entity.nil?
      end
    end

    def transaction(&)
      ActiveRecord::Base.transaction(&)
    end
  end
end
