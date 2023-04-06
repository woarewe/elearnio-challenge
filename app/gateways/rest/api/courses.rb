# frozen_string_literal: true

module REST
  class API
    class Courses < Grape::API
      format "json"

      helpers do
        def find_requested_course!
          params => { id: public_id }
          ::Course.find_by_public_id(public_id).tap { |course| not_found!(:id) if course.nil? }
        end
      end

      mount Create
      mount Index

      route_param :id do
        mount Show
        mount Update
        mount Publish
      end
    end
  end
end
