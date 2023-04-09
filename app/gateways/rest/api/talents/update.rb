# frozen_string_literal: true

module REST
  class API
    class Talents
      class Update < Base
        desc "Update a talent"
        put do
          handle_execution_errors do
            talent = find_requested_talent!
            validate!(params, with: Validation::Talent::Properties)
              .then { |validated| Services::Talent::Update.new.call(talent:, params: validated) }
              .then { |entity| present entity, with: Serialization::Talent }
          end
        end
      end
    end
  end
end
