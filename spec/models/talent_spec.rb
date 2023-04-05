# frozen_string_literal: true

require "rails_helper"

describe Talent, type: :repository do
  shared_context "when a talent with such email already exists" do
    let(:email) { Faker::Internet.unique.email }

    before do
      create(:talent, email:)
    end
  end

  shared_context "when an email has not been taken yet" do
    let(:email) { Faker::Internet.unique.email }
  end

  shared_context "when an email has been already taken" do
    let(:email) { Faker::Internet.unique.email }

    before do
      create(:talent, email:)
    end
  end

  shared_context "when saving properties" do
    let(:properties) { build(:talent, email:).entity_properties }
    let(:saved_record) { described_class.connected_record(result) }
    let(:input) { properties }
  end

  shared_context "when saving an entity" do
    let(:saved_record) { create(:talent, :unique) }
    let(:properties) { build(:talent, :unique, email:).entity_properties }
    let(:entity) { saved_record.entity.update_properties(properties) }
    let(:input) { entity }

    before do
      saved_record
    end
  end

  shared_examples "raising not unique email error" do
    it { expect { result }.to raise_error(described_class::EmailDuplicationError) }
  end

  shared_examples "saving a record with required properties" do
    before do
      result
    end

    it { expect(saved_record.reload).to have_attributes(described_class.serialize_entity_properties(properties)) }
  end

  shared_examples "not changing the existing record" do
    it { expect { silence_errors { result } }.not_to(change { saved_record.reload.attributes }) }
  end

  shared_examples "not creating a new record" do
    it { expect { silence_errors { result } }.not_to(change { described_class.count }) }
  end

  shared_examples "returning an entity with valid properties" do
    before do
      result
      saved_record.reload
    end

    it { expect(result.properties).to eq(properties) }
    it { expect(result.timestamps).to eq(saved_record.entity_timestamps) }
    it { expect(result.private_id).to eq(saved_record.id) }
    it { expect(result.public_id).to eq(saved_record.public_id) }
  end

  describe "#save!" do
    subject(:result) { described_class.save!(input) }

    context do
      include_context "when saving properties"
      include_context "when an email has not been taken yet"

      it_behaves_like "saving a record with required properties"
      it_behaves_like "returning an entity with valid properties"
    end

    context do
      include_context "when saving properties"
      include_context "when an email has been already taken"

      it_behaves_like "raising not unique email error"
      it_behaves_like "not creating a new record"
    end

    context do
      include_context "when saving an entity"
      include_context "when an email has not been taken yet"

      it_behaves_like "saving a record with required properties"
      it_behaves_like "returning an entity with valid properties"
    end

    context do
      include_context "when saving an entity"
      include_context "when an email has been already taken"

      it_behaves_like "not changing the existing record"
      it_behaves_like "raising not unique email error"
    end
  end
end
