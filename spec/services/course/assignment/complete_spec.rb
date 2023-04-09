# frozen_string_literal: true

require "rails_helper"

describe Services::Course::Assignment::Complete, type: :service do
  include Tests::Helpers::Repositories::Talent
  include Tests::Helpers::Repositories::LearningPath
  include Tests::Helpers::Repositories::Course
  include Tests::Helpers::Repositories::Course::Assignment

  let(:input) { course_assignment }
  let(:talent) { build(:talent) }
  let(:course_assignment_record) { persist_course_assignment!(course_assignment) }

  before do
    course_assignment_record
  end

  context "when a talent has only course assignment" do
    let(:course_assignment_properties) { build(:course_assignment_properties, talent:, status: current_status) }
    let(:course_assignment) { build(:course_assignment, properties: course_assignment_properties) }

    context "when an assignment is in progress" do
      let(:current_status) { Types::LearningMaterial::AssignmentStatus::IN_PROGRESS }
      let(:expected_status) { Types::LearningMaterial::AssignmentStatus::COMPLETED }

      it "marks the assignment as complete" do
        expect { result }.to(
          change { course_assignment_record.reload.status }.from(current_status).to(expected_status)
        )
      end
    end
  end
end
