# frozen_string_literal: true

module REST
  class API
    class Talents
      class Show < Base
        desc "Show a talent"
        get do
          find_requested_resource!
            .then { |entity| present entity, with: Serialization::Talent }
        end
      end
    end
  end
end
