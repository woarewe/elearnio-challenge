# frozen_string_literal: true

module REST
  class API
    class Talents
      class Index < Base
        desc "Show talents"
        get do
          validated = pagination_params!(params)
          present_paginated(::Repositories::Talent.all, **validated, with: Serialization::Talent)
        end
      end
    end
  end
end
