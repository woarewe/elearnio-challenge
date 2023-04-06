# frozen_string_literal: true

module REST
  class API
    class LearningPaths < Grape::API
      format "json"

      helpers do
        def find_requested_learning_path!
          params => { id: public_id }
          ::LearningPath.find_by_public_id(public_id).tap { |learning_path| not_found!(:id) if learning_path.nil? }
        end
      end

      mount Create
      mount Index

      route_param :id do
        mount Show
        mount Update
        mount Delete
        mount Publish
      end
    end
  end
end
