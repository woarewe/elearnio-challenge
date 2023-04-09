# frozen_string_literal: true

require "rails_helper"

describe Repositories::LearningPath, type: :repository do
  include Tests::Helpers::Repositories::Course
  include Tests::Helpers::Repositories::Talent
  include Tests::Helpers::Repositories::LearningPath

  describe "#save!" do
    subject(:result) { described_class.save!(input) }

    let(:author) { build(:talent) }
    let(:courses) { build_list(:course, 5, :published) }

    before do
      persist_talent!(author)
      courses.map { |course| persist_course!(course) }
    end

    shared_context "when a name has been already taken" do
      let(:name) { Faker::Lorem.unique.question }
      let(:record) do
        entity = build(:learning_path, properties: build(:learning_path_properties, name:))
        persist_learning_path!(entity)
      end

      before do
        record
      end
    end

    shared_context "when a name has not been taken yet" do
      let(:name) { Faker::Lorem.unique.question }
    end

    shared_context "when saving properties" do
      let(:properties) { build(:learning_path_properties, name:, author:, courses:) }
      let(:input) { properties }
    end

    shared_context "when saving persisted entity" do # rubocop:disable RSpec/MultipleMemoizedHelpers
      let(:persisted_entity) { build(:learning_path) }
      let(:updated_entity) do
        build(
          :learning_path,
          private_id: persisted_entity.private_id,
          public_id: persisted_entity.public_id,
          properties: build(:learning_path_properties, name:, author:, courses:)
        )
      end
      let(:input) { updated_entity }
      let(:persisted_record) { persist_learning_path!(persisted_entity) }

      before do
        persisted_record
      end
    end

    shared_examples "raising not unique name error" do
      it { expect { result }.to raise_error(described_class::NameDuplicationError) }
    end

    shared_examples "not changing the existing record" do
      it { expect { silence_errors { result } }.not_to(change { persisted_record.reload.attributes }) }
      it { expect { silence_errors { result } }.not_to(change { persisted_record.reload.slots.as_json }) }
    end

    shared_examples "not creating a new record" do
      it { expect { silence_errors { result } }.not_to(change { described_class.count }) }
    end

    shared_examples "creating a new record" do
      it { expect { result }.to(change { described_class.count }.by(1)) }
    end

    shared_examples "persisting required attributes" do
      let(:record) { result.record }
      let(:expected_slot_attributes) do
        input.courses.each_with_index.map do |course, index|
          { learning_path_id: record.id, course_id: course.private_id, position: index + 1 }
        end
      end

      before do
        result
      end

      it { expect(record.author_id).to eq(input.author.private_id) }
      it { expect(record.name).to eq(input.name) }
      it { expect(record.status).to eq(input.status) }

      it "saves slots with correct values", :aggregate_failures do
        record.slots.each_with_index do |slot, index|
          expect(slot).to have_attributes(expected_slot_attributes[index])
        end
      end
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
