# frozen_string_literal: true

module REST
  class API
    class Courses
      class Assignments
        class Complete < Base
          desc "Complete a course assignment"
          patch do
            find_requested_resource!
              .then { |assignment| Services::Course::Assignment::Complete.new.call(assignment) }
              .then { |entity| present entity, with: Serialization::Course::Assignment }
          rescue ::Types::LearningMaterial::Assignment::AlreadyCompletedError
            already_completed!
          end
        end
      end
    end
  end
end
