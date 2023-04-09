# frozen_string_literal: true

module REST
  class API
    class Talents
      class Create < Base
        desc "Create a talent"
        post do
          handle_execution_errors do
            validate!(params, with: Validation::Talent::Properties)
              .then { |validated| Services::Talent::Create.new.call(validated) }
              .then { |entity| present entity, with: Serialization::Talent }
          end
        end
      end
    end
  end
end
