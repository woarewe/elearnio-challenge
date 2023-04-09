# frozen_string_literal: true

module REST
  class API
    class LearningPaths < Grape::API
      format "json"

      helpers(Helpers::LearningPaths, Helpers::LearningMaterials)

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
