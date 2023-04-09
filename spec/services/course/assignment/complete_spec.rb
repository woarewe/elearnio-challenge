# frozen_string_literal: true

require "rails_helper"

describe Services::Course::Assignment::Complete, type: :service do
  include Tests::Helpers::Repositories::Talent
  include Tests::Helpers::Repositories::LearningPath
  include Tests::Helpers::Repositories::Course
  include Tests::Helpers::Repositories::Course::Assignment
  include Tests::Helpers::Repositories::LearningPath::Assignment

  let(:input) { course_assignment }
  let(:talent) { build(:talent) }
  let(:course_assignment_record) { persist_course_assignment!(course_assignment) }
  let(:course_assignment_properties) { build(:course_assignment_properties, course:, talent:, status: current_status) }
  let(:course_assignment) { build(:course_assignment, properties: course_assignment_properties) }
  let(:completed_status) { Types::LearningMaterial::AssignmentStatus::COMPLETED }
  let(:in_progress_status) { Types::LearningMaterial::AssignmentStatus::IN_PROGRESS }

  before do
    course_assignment_record
  end

  context "when a talent has only course assigned" do
    let(:course) { build(:course, :published) }

    context "when an assignment is in progress" do
      let(:current_status) { in_progress_status }

      it "marks the assignment as complete" do
        expect { result }.to(
          change { course_assignment_record.reload.status }.from(current_status).to(completed_status)
        )
      end
    end

    context "when an assignment has been already completed" do
      let(:current_status) { completed_status }

      it { expect { result }.to raise_error(Types::Course::Assignment::AlreadyCompletedError) }
    end
  end

  context "when the assigned course is included in other learning paths" do
    let(:current_status) { Types::LearningMaterial::AssignmentStatus::IN_PROGRESS }
    let(:course) { build(:course, :published) }
    let(:learning_path_a) do
      build(:learning_path, properties: build(:learning_path_properties, :published, courses: learning_path_a_courses))
    end
    let(:learning_path_b) do
      build(:learning_path, properties: build(:learning_path_properties, :published, courses: learning_path_b_courses))
    end
    let(:learning_path_c) do
      build(:learning_path, properties: build(:learning_path_properties, :published, courses: learning_path_c_courses))
    end
    let(:learning_paths) { [learning_path_a, learning_path_b, learning_path_c] }
    let(:learning_path_a_courses) { [course, *build_list(:course, 2, :published)] }
    let(:learning_path_b_courses) { [course, *build_list(:course, 2, :published)] }
    let(:learning_path_c_courses) { [course, *build_list(:course, 2, :published)] }
    let(:assigned_learning_paths) { [learning_path_a, learning_path_c] }
    let(:learning_path_assignments) do
      assigned_learning_paths.map do |learning_path|
        build(
          :learning_path_assignment,
          properties: build(:learning_path_assignment_properties, talent:, learning_path:)
        )
      end
    end

    before do
      learning_paths.each { |learning_path| persist_learning_path!(learning_path) }
      persist_learning_path_assignments!(learning_path_assignments)
    end

    context "when the assigned course is first uncompleted in assigned learning paths" do
      before do
        result
      end

      it "assigns new courses going next in assigned learning paths", :aggregate_failures do
        learning_path_a_next = find_course_assignment(talent:, course: learning_path_a_courses[1])
        learning_path_b_next = find_course_assignment(talent:, course: learning_path_b_courses[1])
        learning_path_c_next = find_course_assignment(talent:, course: learning_path_c_courses[1])

        expect(learning_path_a_next.status).to eq(in_progress_status)
        expect(learning_path_c_next.status).to eq(in_progress_status)
        expect(learning_path_b_next).to be_nil
      end
    end

    context "when the assigned course has a completed course ahead" do
      let(:learning_path_a_middle_course_assignment) do
        build(
          :course_assignment,
          :completed,
          properties: build(
            :course_assignment_properties,
            course: learning_path_a_courses[1],
            talent:
          )
        )
      end

      let(:learning_path_b_middle_course_assignment) do
        build(
          :course_assignment,
          :completed,
          properties: build(
            :course_assignment_properties,
            course: learning_path_b_courses[1],
            talent:
          )
        )
      end

      let(:learning_path_c_middle_course_assignment) do
        build(
          :course_assignment,
          :completed,
          properties: build(
            :course_assignment_properties,
            course: learning_path_c_courses[1],
            talent:
          )
        )
      end

      before do
        persist_course_assignment!(learning_path_a_middle_course_assignment)
        persist_course_assignment!(learning_path_b_middle_course_assignment)
        persist_course_assignment!(learning_path_c_middle_course_assignment)
        result
      end

      it "assigns new courses going next in assigned learning paths", :aggregate_failures do
        learning_path_a_next = find_course_assignment(talent:, course: learning_path_a_courses[2])
        learning_path_b_next = find_course_assignment(talent:, course: learning_path_b_courses[2])
        learning_path_c_next = find_course_assignment(talent:, course: learning_path_c_courses[2])

        expect(learning_path_a_next.status).to eq(in_progress_status)
        expect(learning_path_c_next.status).to eq(in_progress_status)
        expect(learning_path_b_next).to be_nil
      end
    end

    context "when the course is the last in assigned learning paths" do
      let(:learning_path_a_courses) { [*build_list(:course, 1, :published), course] }
      let(:learning_path_b_courses) { [*build_list(:course, 1, :published), course] }
      let(:learning_path_c_courses) { [*build_list(:course, 1, :published), course] }

      let(:learning_path_a_previous_course_assignment) do
        build(
          :course_assignment,
          :completed,
          properties: build(
            :course_assignment_properties,
            course: learning_path_a_courses[0],
            talent:
          )
        )
      end

      let(:learning_path_b_previous_course_assignment) do
        build(
          :course_assignment,
          :completed,
          properties: build(
            :course_assignment_properties,
            course: learning_path_b_courses[0],
            talent:
          )
        )
      end

      let(:learning_path_c_previous_course_assignment) do
        build(
          :course_assignment,
          :completed,
          properties: build(
            :course_assignment_properties,
            course: learning_path_c_courses[0],
            talent:
          )
        )
      end

      it "does not create any new assignment" do
        expect { result }.not_to(change { Repositories::Course::Assignment.count })
      end
    end
  end
end
