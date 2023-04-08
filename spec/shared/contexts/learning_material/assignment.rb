# frozen_string_literal: true

module Tests
  module Shared
    module Contexts
      module LearningMaterial
        module Assignment
          extend ActiveSupport::Concern

          included do
            shared_context "when a learning material is a published course" do
              let(:learning_material) { build(:course, :published) }
            end

            shared_context "when a learning material is a published learning path" do
              let(:learning_material) { build(:learning_path, :published) }
            end

            shared_context "when a learning material is a not published yet learning path" do
              let(:learning_material) { build(:learning_path, :draft) }
            end

            shared_context "when a learning material is a not published yet course" do
              let(:learning_material) { build(:course, :draft) }
            end

            shared_context "when assigning to the author of the learning material" do
              let(:talent) { learning_material.properties.author }
            end

            shared_context "when assigning to a co-author of the learning path" do
              let(:talent) { learning_material.co_authors.sample }
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
