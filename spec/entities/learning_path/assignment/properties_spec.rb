# frozen_string_literal: true

require "rails_helper"

describe Types::LearningPath::Assignment::Properties do
  include Tests::Shared::Contexts::LearningPath::Assignment
  include Tests::Shared::Examples::LearningPath::Assignment

  describe "#new" do
    subject(:instance) { described_class.new(learning_path:, talent:, status:) }

    let(:status) { Types::LearningMaterial::AssignmentStatus.enum.values.sample }

    context do
      include_context "when a learning path is published"
      include_context "when assigning to the learning path author"

      it { expect { instance }.to raise_error(Types::LearningMaterial::Assignment::AssigningToAuthorError) }
    end

    context do
      include_context "when a learning path is not published"
      include_context "when assigning to another talent"

      it { expect { instance }.to raise_error(Types::LearningMaterial::Assignment::AssigningNotPublishedError) }
    end

    context do
      include_context "when a learning path is published"
      include_context "when assigning to an author of any inner course"

      it { expect { instance }.to raise_error(Types::LearningPath::Assignment::AssigningToCourseAuthorError) }
    end

    context do
      include_context "when a learning path is published"
      include_context "when assigning to another talent"

      it_behaves_like "instantiating a learning path assignment properties with the required attributes"
    end
  end
end
