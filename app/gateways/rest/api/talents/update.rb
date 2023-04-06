# frozen_string_literal: true

module REST
  class API
    class Talents
      class Update < Base
        desc "Update a talent"
        put do
          talent = find_requested_talent!
          validate!(params, with: Validation::Talent::Properties)
            .then { |validated| ::Types::Talent::Properties.new(validated) }
            .then { |properties| talent.update_properties(properties) }
            .then { |entity| ::Talent.save!(entity) }
            .then { |entity| present entity, with: Serialization::Talent }
        rescue ::Talent::EmailDuplicationError
          validation_error!(:email, I18n.t("rest.errors.already_taken"))
        end
      end
    end
  end
end
