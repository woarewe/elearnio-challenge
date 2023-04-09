# frozen_string_literal: true

module REST
  class API
    class Courses < Grape::API
      format "json"

      helpers(Helpers::Courses, Helpers::LearningMaterials)

      mount Create
      mount Index

      route_param :id do
        mount Show
        mount Update
        mount Delete
        mount Publish
      end

      namespace(:assignments) { mount Assignments }
    end
  end
end
