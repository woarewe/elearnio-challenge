# frozen_string_literal: true

module REST
  class API
    class Talents
      class Delete < Base
        desc "Delete a talent"
        delete do
          status 204
          find_requested_talent!
            .then { |talent| ::Talent.delete(talent.private_id) }
        end
      end
    end
  end
end
