# frozen_string_literal: true

module Tests
  module Shared
    module Examples
      module LearningPath
        module Assignment
          extend ActiveSupport::Concern

          included do
            shared_examples "instantiating a learning path assignment properties with the required attributes" do
              it { expect(instance.talent).to eq(talent) }
              it { expect(instance.learning_path).to eq(learning_path) }
            end
          end
        end
      end
    end
  end
end
