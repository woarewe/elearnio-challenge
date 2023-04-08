# frozen_string_literal: true

module Tests
  module Shared
    module Examples
      module LearningMaterial
        module Assignment
          extend ActiveSupport::Concern

          included do
            shared_examples "creating an assignment properties with given attributes" do
              it { expect(instance.talent).to eq(talent) }
              it { expect(instance.learning_material).to eq(learning_material) }
              it { expect(instance.status).to eq(status) }
            end
          end
        end
      end
    end
  end
end
