# frozen_string_literal: true

module Tests
  module Shared
    module Contexts
      module Course
        module Assignment
          extend ActiveSupport::Concern

          included do
            shared_context "when a course is not published" do
              let(:course) { build(:course, :draft) }
            end

            shared_context "when a course is published" do
              let(:course) { build(:course, :published) }
            end

            shared_context "when assigning to the course author" do
              let(:talent) { course.author }
            end

            shared_context "when assigning to another talent" do
              let(:talent) { build(:talent) }
            end
          end
        end
      end
    end
  end
end
