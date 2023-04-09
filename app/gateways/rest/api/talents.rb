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
      end
    end
  end
end
