# frozen_string_literal: true

module Tests
  module Shared
    module Examples
      module Course
        module Assignment
          extend ActiveSupport::Concern

          included do
            shared_examples "instantiating a course assignment properties with the required attributes" do
              it { expect(instance.talent).to eq(talent) }
              it { expect(instance.course).to eq(course) }
              it { expect(instance.status).to eq(status) }
            end
          end
        end
      end
    end
  end
end
