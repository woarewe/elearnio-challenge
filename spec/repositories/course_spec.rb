# frozen_string_literal: true

require "rails_helper"

describe Repositories::Course, type: :repository do
  include Tests::Helpers::Repositories::Course
  include Tests::Helpers::Repositories::Talent

  describe "#save!" do
    subject(:result) { described_class.save!(input) }

    let(:author) { build(:talent) }

    before do
      persist_talent!(author)
    end

    shared_context "when a name has been already taken" do
      let(:name) { Faker::Lorem.unique.question }
      let(:record) do
        entity = build(:course, properties: build(:course_properties, name:))
        persist_course!(entity)
      end

      before do
        record
      end
    end

    shared_context "when a name has not been taken yet" do
      let(:name) { Faker::Lorem.unique.question }
    end

    shared_context "when saving properties" do
      let(:properties) { build(:course_properties, name:, author:) }
      let(:input) { properties }
    end

    shared_context "when saving persisted entity" do
      let(:persisted_entity) { build(:course) }
      let(:updated_entity) do
        build(
          :course,
          private_id: persisted_entity.private_id,
          public_id: persisted_entity.public_id,
          properties: build(:course_properties, name:, author:)
        )
      end
      let(:input) { updated_entity }
      let(:persisted_record) { persist_course!(persisted_entity) }

      before do
        persisted_record
      end
    end

    shared_examples "raising not unique name error" do
      it { expect { result }.to raise_error(described_class::NameDuplicationError) }
    end

    shared_examples "not changing the existing record" do
      it { expect { silence_errors { result } }.not_to(change { persisted_record.reload.attributes }) }
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

      it { expect(record.author_id).to eq(input.author.private_id) }
      it { expect(record.name).to eq(input.name) }
      it { expect(record.content).to eq(input.content) }
      it { expect(record.status).to eq(input.status) }
    end

    context do
      include_context "when saving properties"
      include_context "when a name has been already taken"

      it_behaves_like "raising not unique name error"
      it_behaves_like "not creating a new record"
    end

    context do
      include_context "when saving persisted entity"
      include_context "when a name has been already taken"

      it_behaves_like "raising not unique name error"
      it_behaves_like "not creating a new record"
    end

    context do
      include_context "when saving properties"
      include_context "when a name has not been taken yet"

      it_behaves_like "creating a new record"
      it_behaves_like "persisting required attributes"
    end

    context do
      include_context "when saving persisted entity"
      include_context "when a name has not been taken yet"

      it_behaves_like "not creating a new record"
      it_behaves_like "persisting required attributes"
    end
  end
end
