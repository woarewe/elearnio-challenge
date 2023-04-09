# frozen_string_literal: true

require "rails_helper"

describe Services::Talent::Delete, type: :service do
  include Tests::Helpers::Repositories::Talent
  include Tests::Helpers::Repositories::LearningPath
  include Tests::Helpers::Repositories::LearningPath::Assignment
  include Tests::Helpers::Repositories::Course
  include Tests::Helpers::Repositories::Course::Assignment

  subject(:result) { instance.call(talent:, params:) }

  let(:talent) { build(:talent) }
  let(:new_author) { build(:talent) }
  let(:params) { {} }

  before do
    persist_talent!(talent)
    persist_talent!(new_author)
  end

  shared_context "when there is no new author provided in params" do
    let(:params) { {} }
  end

  shared_context "when a new author is not found" do
    let(:params) { { new_author_id: SecureRandom.uuid } }
  end

  shared_context "when a new author is found" do
    let(:params) { { new_author_id: new_author.public_id } }
  end

  shared_context "when a new author is the talent" do
    let(:params) { { new_author_id: talent.public_id } }
  end

  shared_context "when a talent is an author of a course" do
    let(:course) do
      build(:course, properties: build(:course_properties, :published, author: talent))
    end

    before do
      persist_course!(course)
    end
  end

  shared_context "when a talent is an author of a learning path" do
    let(:learning_path) do
      build(:learning_path, properties: build(:learning_path_properties, :published, author: talent))
    end

    before do
      persist_learning_path!(learning_path)
    end
  end

  shared_context "when a talent has assigned learning materials" do
    let(:course_assignment) do
      build(:course_assignment, properties: build(:course_assignment_properties, talent:))
    end

    let(:learning_path_assignment) do
      build(:learning_path_assignment, properties: build(:learning_path_assignment_properties, talent:))
    end

    before do
      persist_course_assignment!(course_assignment)
      persist_learning_path_assignment!(learning_path_assignment)
    end
  end

  shared_context "when the new author has a course assignment with moving course" do
    let(:course_assignment) do
      build(:course_assignment, properties: build(:course_assignment_properties, talent: new_author, course:))
    end

    before do
      persist_course_assignment!(course_assignment)
    end
  end

  shared_context "when the new author has a learning path assignment with moving course" do
    let(:learning_path_assignment) do
      build(
        :learning_path_assignment,
        properties: build(:learning_path_assignment_properties, talent: new_author, learning_path:)
      )
    end

    before do
      persist_learning_path_assignment!(learning_path_assignment)
    end
  end

  shared_examples "deleting the talent" do
    before { result }

    it { expect(Repositories::Talent.connected_record(talent)).to be_nil }
  end

  shared_examples "moving ownership of the course to the new author" do
    before { result }

    it do
      refreshed_entity = Repositories::Course.connected_record(course).entity
      expect(refreshed_entity.author).to eq(new_author)
    end
  end

  shared_examples "moving ownership of the learning path to the new author" do
    before { result }

    it do
      refreshed_entity = Repositories::LearningPath.connected_record(learning_path).entity
      expect(refreshed_entity.author).to eq(new_author)
    end
  end

  context "when a talent is not an author" do
    before { result }

    it { expect(Repositories::Talent.connected_record(talent)).to be_nil }
  end

  context do
    include_context "when a talent is an author of a course"
    include_context "when there is no new author provided in params"

    it { expect { result }.to raise_error(described_class::NoNewAuthorProvidedError) }
  end

  context do
    include_context "when a talent is an author of a course"
    include_context "when a new author is not found"

    it "returns not found errors with the required key", :aggregate_failures do
      expect { result }.to raise_error(Services::NotFoundError) do |error|
        expect(error.key).to eq(:new_author_id)
      end
    end
  end

  context do
    include_context "when a talent is an author of a course"
    include_context "when a new author is the talent"

    it { expect { result }.to raise_error(described_class::SameTalentError) }
  end

  context do
    include_context "when a talent is an author of a course"
    include_context "when a new author is found"
    include_context "when the new author has a course assignment with moving course"

    it { expect { result }.to raise_error(described_class::NewAuthorAssignedToMaterialError) }
  end

  context do
    include_context "when a talent is an author of a learning path"
    include_context "when a new author is found"
    include_context "when the new author has a learning path assignment with moving course"

    it { expect { result }.to raise_error(described_class::NewAuthorAssignedToMaterialError) }
  end

  context do
    include_context "when a talent is an author of a learning path"
    include_context "when a new author is found"

    it_behaves_like "deleting the talent"
    it_behaves_like "moving ownership of the learning path to the new author"
  end

  context do
    include_context "when a talent is an author of a course"
    include_context "when a new author is found"

    it_behaves_like "deleting the talent"
    it_behaves_like "moving ownership of the course to the new author"
  end

  context do
    include_context "when a talent is an author of a learning path"
    include_context "when a talent is an author of a course"
    include_context "when a new author is found"
    include_context "when a talent has assigned learning materials"

    it_behaves_like "moving ownership of the learning path to the new author"
    it_behaves_like "moving ownership of the course to the new author"
  end
end
