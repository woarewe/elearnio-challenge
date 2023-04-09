# frozen_string_literal: true

module Repositories
  module LearningMaterial
    module Assignment
      extend ActiveSupport::Concern

      Error = Class.new(StandardError)
      AlreadyAssignedError = Class.new(Error)

      included do
        instance_exec do
          def handle_database_errors
            yield
          rescue ActiveRecord::RecordNotUnique
            raise AlreadyAssignedError
          end
        end
      end
    end
  end
end
