# frozen_string_literal: true

module REST
  class API
    class Talents < Grape::API
      format "json"

      helpers do
        def find_requested_talent!
          params => { id: public_id }
          ::Talent.find_by_public_id(public_id).tap { |talent| not_found!(:id) if talent.nil? }
        end
      end

      mount Create
      mount Index

      route_param :id do
        mount Show
        mount Update
        mount Delete
      end
    end
  end
end
