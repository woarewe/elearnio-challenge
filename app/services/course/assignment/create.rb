# frozen_string_literal: true

module Services
  module Course
    module Assignment
      class Create < Services::Base
        def call(params)
          talent = find_talent!(params, as: :talent_id)
          find_course!(params)
            .then { |course| build_properties(talent, course) }
            .then { |properties| Repositories::Course::Assignment.save!(properties) }
            .then(&:entity)
        end

        private

        def find_course!(params)
          params => { course_id: }
          ::Repositories::Course.seek(course_id).tap do |course|
            raise NotFoundError, :course_id if course.nil?
          end
        end

        def build_properties(talent, course)
          ::Types::Course::Assignment::Properties.new(talent:, course:, status: initial_status)
        end

        def initial_status
          ::Types::LearningMaterial::AssignmentStatus::IN_PROGRESS
        end
      end
    end
  end
end
