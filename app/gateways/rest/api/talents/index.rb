# frozen_string_literal: true

module REST
  class API
    class Talents
      class Index < Base
        desc "Show talents"
        get do
          pagination_params!(params)
            .then { |validated| present_paginated(::Talent.all, **validated, with: Serialization::Talent) }
        end
      end
    end
  end
end
