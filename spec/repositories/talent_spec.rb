# frozen_string_literal: true

require "rails_helper"

describe Repositories::Talent, type: :repository do
  include Tests::Helpers::Repositories::Talent

  describe "#save!" do
    subject(:result) { described_class.save!(input) }

    shared_context "when an email has been already taken" do
      let(:email) { Faker::Internet.unique.email }
      let(:record) do
        entity = build(:talent, properties: build(:talent_properties, email:))
        persist_entity!(entity)
      end

      before do
        record
      end
    end

    shared_context "when an email has not been taken yet" do
      let(:email) { Faker::Internet.unique.email }
    end

    shared_context "when saving properties" do
      let(:properties) { build(:talent_properties, email:) }
      let(:input) { properties }
    end

    shared_context "when saving persisted entity" do
      let(:persisted_entity) { build(:talent) }
      let(:updated_entity) do
        build(
          :talent,
          private_id: persisted_entity.private_id,
          public_id: persisted_entity.public_id,
          properties: build(:talent_properties, email:)
        )
      end
      let(:input) { updated_entity }

      before do
        persist_entity!(persisted_entity)
      end
    end

    shared_context "when saving not persisted entity" do
      let(:entity) { build(:talent, properties: build(:talent_properties, email:)) }
      let(:input) { entity }
    end

    shared_examples "raising not unique email error" do
      it { expect { result }.to raise_error(described_class::EmailDuplicationError) }
    end

    shared_examples "not changing the existing record" do
      it { expect { silence_errors { result } }.not_to(change { saved_record.reload.attributes }) }
    end

    shared_examples "not creating a new record" do
      it { expect { silence_errors { result } }.not_to(change { described_class.count }) }
    end

    shared_examples "creating a new record" do
      it { expect { result }.to(change { described_class.count }.by(1)) }
    end

    shared_examples "persisting required attributes" do
      let(:record) { result.record }

      before do
        result
      end

      it { expect(record.first_name).to eq(input.first_name) }
      it { expect(record.last_name).to eq(input.last_name) }
      it { expect(record.email).to eq(input.email) }
    end

    context do
      include_context "when saving properties"
      include_context "when an email has been already taken"

      it_behaves_like "raising not unique email error"
      it_behaves_like "not creating a new record"
    end

    context do
      include_context "when saving persisted entity"
      include_context "when an email has been already taken"

      it_behaves_like "raising not unique email error"
      it_behaves_like "not creating a new record"
    end

    context do
      include_context "when saving not persisted entity"
      include_context "when an email has been already taken"

      it_behaves_like "raising not unique email error"
      it_behaves_like "not creating a new record"
    end

    context do
      include_context "when saving properties"
      include_context "when an email has not been taken yet"

      it_behaves_like "creating a new record"
      it_behaves_like "persisting required attributes"
    end

    context do
      include_context "when saving not persisted entity"
      include_context "when an email has not been taken yet"

      it_behaves_like "creating a new record"
      it_behaves_like "persisting required attributes"
    end

    context do
      include_context "when saving persisted entity"
      include_context "when an email has not been taken yet"

      it_behaves_like "not creating a new record"
      it_behaves_like "persisting required attributes"
    end
  end
end
