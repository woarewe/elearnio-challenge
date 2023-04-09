# frozen_string_literal: true

require "rails_helper"

describe Types::Course do
  describe "#published?" do
    subject(:result) { instance.published? }

    context "when a course is still in draft" do
      let(:instance) { build(:course, :draft) }

      it { is_expected.to be(false) }
    end

    context "when a course is published" do
      let(:instance) { build(:course, :published) }

      it { is_expected.to be(true) }
    end
  end

  describe "#draft?" do
    subject(:result) { instance.draft? }

    context "when a course is still in draft" do
      let(:instance) { build(:course, :draft) }

      it { is_expected.to be(true) }
    end

    context "when a course is published" do
      let(:instance) { build(:course, :published) }

      it { is_expected.to be(false) }
    end
  end
end
