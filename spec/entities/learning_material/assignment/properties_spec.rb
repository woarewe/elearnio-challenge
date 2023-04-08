# frozen_string_literal: true

require "rails_helper"

describe Types::LearningMaterial::Assignment::Properties, type: :entity do
  include Tests::Shared::Contexts::LearningMaterial::Assignment
  include Tests::Shared::Examples::LearningMaterial::Assignment

  describe "#new" do
    subject(:instance) { described_class.new(attributes) }

    let(:attributes) do
      { talent:, learning_material:, status: }
    end
    let(:status) do
      build(:learning_material_assignment_status)
    end

    context do
      include_context "when a learning material is a published course"
      include_context "when assigning to the author of the learning material"

      it { expect { instance }.to raise_error(Types::LearningMaterial::Assignment::AssigningToAuthorError) }
    end

    context do
      include_context "when a learning material is a published learning path"
      include_context "when assigning to the author of the learning material"

      it { expect { instance }.to raise_error(Types::LearningMaterial::Assignment::AssigningToAuthorError) }
    end

    context do
      include_context "when a learning material is a published learning path"
      include_context "when assigning to a co-author of the learning path"

      it { expect { instance }.to raise_error(Types::LearningMaterial::Assignment::AssigningToCoAuthorError) }
    end

    context do
      include_context "when a learning material is a not published yet learning path"
      include_context "when assigning to another talent"

      it { expect { instance }.to raise_error(Types::LearningMaterial::Assignment::NotPublishedLearningMaterialError) }
    end

    context do
      include_context "when a learning material is a not published yet course"
      include_context "when assigning to another talent"

      it { expect { instance }.to raise_error(Types::LearningMaterial::Assignment::NotPublishedLearningMaterialError) }
    end

    context do
      include_context "when a learning material is a published course"
      include_context "when assigning to another talent"

      it_behaves_like "creating an assignment properties with given attributes"
    end

    context do
      include_context "when a learning material is a published learning path"
      include_context "when assigning to another talent"

      it_behaves_like "creating an assignment properties with given attributes"
    end
  end
end
