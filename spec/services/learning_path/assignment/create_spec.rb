# frozen_string_literal: true

require "rails_helper"

describe Services::LearningPath::Assignment::Create, type: :service do
  include Tests::Helpers::Repositories::LearningPath
  include Tests::Helpers::Repositories::Talent

  let(:input) do
    { talent_id:, learning_path_id: }
  end
  let(:dependencies) do
    { assign_next_course: }
  end
  let(:assign_next_course) { Services::LearningPath::AssignNextCourse.new }
  let(:talent) { build(:talent) }
  let(:learning_path) { build(:learning_path, :published) }

  before do
    allow(assign_next_course).to receive(:call)
    persist_talent!(talent)
    persist_learning_path!(learning_path)
  end

  shared_context "when a talent is found" do
    let(:talent_id) { talent.public_id }
  end

  shared_context "when a talent is not found" do
    let(:talent_id) { SecureRandom.uuid }
  end

  shared_context "when a learning path is found" do
    let(:learning_path_id) { learning_path.public_id }
  end

  shared_context "when a learning path is not found" do
    let(:learning_path_id) { SecureRandom.uuid }
  end

  shared_examples "not creating a course assignment" do
    before { silence_errors { result } }

    it { expect(assign_next_course).not_to have_received(:call) }
  end

  shared_examples "raising not found error" do |with_key:|
    it "raises error with required info", :aggregate_failures do
      expect { result }.to raise_error(Services::NotFoundError) do |error|
        expect(error.key).to eq(with_key)
      end
    end
  end

  shared_examples "creating a new learning path assignment" do
    let(:record) do
      Repositories::LearningPath::Assignment.find_by(
        talent_id: talent.private_id,
        learning_path_id: learning_path.private_id
      )
    end

    before { result }

    it { expect(record).not_to be_nil }
  end

  shared_examples "creating a course assignment" do
    before { result }

    it { expect(assign_next_course).to have_received(:call).with(learning_path:, talent:) }
  end

  context do
    include_context "when a talent is found"
    include_context "when a learning path is not found"

    it_behaves_like "raising not found error", with_key: :learning_path_id
    it_behaves_like "not creating a course assignment"
  end

  context do
    include_context "when a talent is not found"
    include_context "when a learning path is found"

    it_behaves_like "raising not found error", with_key: :talent_id
    it_behaves_like "not creating a course assignment"
  end

  context do
    include_context "when a talent is found"
    include_context "when a learning path is found"

    it_behaves_like "creating a new learning path assignment"
    it_behaves_like "creating a course assignment"
  end
end
