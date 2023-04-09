# frozen_string_literal: true

require "rails_helper"

describe Types::LearningPath do
  describe "#next_course" do
    subject(:result) { instance.next_course(assignments) }

    let(:instance) { build(:learning_path, properties: build(:learning_path_properties, courses:)) }
    let(:courses) { build_list(:course, 3, :published) }
    let(:talent) { build(:talent) }
    let(:assignments) { assignments_properties.map { |properties| build(:course_assignment, properties:) } }

    shared_examples "returning nothing because there are other courses in progress" do
      it { is_expected.to be_nil }
    end

    context "when no progress" do
      let(:assignments_properties) { [] }

      it "returns the first course of the learning path" do
        expect(result).to eq(courses.first)
      end
    end

    context "when the first course is completed" do
      let(:assignments_properties) do
        [
          build(:course_assignment_properties, :completed, course: courses.first, talent:)
        ]
      end

      it "returns the second course of the learning path" do
        expect(result).to eq(courses.second)
      end
    end

    context "when the first two courses are in progress and the second is completed" do
      let(:assignments_properties) do
        [
          build(:course_assignment_properties, :in_progress, course: courses.first, talent:),
          build(:course_assignment_properties, :completed, course: courses.second, talent:)
        ]
      end

      it_behaves_like "returning nothing because there are other courses in progress"
    end

    context "when the first two courses are in progress and the first is completed" do
      let(:assignments_properties) do
        [
          build(:course_assignment_properties, :completed, course: courses.first, talent:),
          build(:course_assignment_properties, :in_progress, course: courses.second, talent:)
        ]
      end

      it_behaves_like "returning nothing because there are other courses in progress"
    end

    context "when the first course is in progress" do
      let(:assignments_properties) do
        [
          build(:course_assignment_properties, :in_progress, course: courses.first, talent:)
        ]
      end

      it_behaves_like "returning nothing because there are other courses in progress"
    end

    context "when the first two courses are completed and the last is in progress" do
      let(:assignments_properties) do
        [
          build(:course_assignment_properties, :completed, course: courses.first, talent:),
          build(:course_assignment_properties, :completed, course: courses.second, talent:),
          build(:course_assignment_properties, :in_progress, course: courses.third, talent:)
        ]
      end

      it_behaves_like "returning nothing because there are other courses in progress"
    end

    context "when all courses are completed" do
      let(:assignments_properties) do
        [
          build(:course_assignment_properties, :completed, course: courses.first, talent:),
          build(:course_assignment_properties, :completed, course: courses.second, talent:),
          build(:course_assignment_properties, :completed, course: courses.third, talent:)
        ]
      end

      it "returns nothing because everything is done" do
        expect(result).to be_nil
      end
    end
  end
end
