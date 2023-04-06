# frozen_string_literal: true

module REST
  class API
    class Talents
      class Create < Base
        desc "Create a talent"
        post do
          validate!(params, with: Validation::Talent::Properties)
            .then { |validated| ::Types::Talent::Properties.new(validated) }
            .then { |properties| ::Talent.save!(properties) }
            .then { |entity| present entity, with: Serialization::Talent }
        rescue ::Talent::EmailDuplicationError
          validation_error!(:email, I18n.t("rest.errors.already_taken"))
        end
      end
    end
  end
end
