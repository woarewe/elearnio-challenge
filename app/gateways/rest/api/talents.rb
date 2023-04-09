# frozen_string_literal: true

module REST
  class API
    class Talents < Grape::API
      format "json"

      helpers(Helpers::Talents)

      mount Create
      mount Index

      route_param :id do
        mount Show
        mount Update
        mount Delete
        mount AssignedLearningPaths
        mount AssignedCourses
      end
    end
  end
end
