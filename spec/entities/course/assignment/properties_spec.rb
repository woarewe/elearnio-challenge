# frozen_string_literal: true

require "rails_helper"

describe Types::Course::Assignment::Properties do
  include Tests::Shared::Contexts::Course::Assignment
  include Tests::Shared::Examples::Course::Assignment

  describe "#new" do
    subject(:instance) { described_class.new(course:, talent:, status:) }

    let(:status) { Types::LearningMaterial::AssignmentStatus.enum.values.sample }

    context do
      include_context "when a course is published"
      include_context "when assigning to the course author"

      it { expect { instance }.to raise_error(Types::Course::Assignment::AssigningToAuthorError) }
    end

    context do
      include_context "when a course is not published"
      include_context "when assigning to another talent"

      it { expect { instance }.to raise_error(Types::LearningMaterial::Assignment::AssigningNotPublishedError) }
    end

    context do
      include_context "when a course is published"
      include_context "when assigning to another talent"

      it_behaves_like "instantiating a course assignment properties with the required attributes"
    end
  end
end
