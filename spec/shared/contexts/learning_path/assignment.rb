# frozen_string_literal: true

module Tests
  module Shared
    module Contexts
      module LearningPath
        module Assignment
          extend ActiveSupport::Concern

          included do
            shared_context "when a learning path is not published" do
              let(:learning_path) { build(:learning_path, :draft) }
            end

            shared_context "when a learning path is published" do
              let(:learning_path) { build(:learning_path, :published) }
            end

            shared_context "when assigning to the learning path author" do
              let(:talent) { learning_path.author }
            end

            shared_context "when assigning to an author of any inner course" do
              let(:talent) { learning_path.courses.map(&:author).sample }
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
