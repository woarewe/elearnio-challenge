# frozen_string_literal: true

module Tests
  module Helpers
    module Services
      extend ActiveSupport::Concern

      included do
        subject(:result) { instance.call(input) }

        let(:instance) { described_class.new(**dependencies) }
        let(:dependencies) { {} }
      end
    end
  end
end
