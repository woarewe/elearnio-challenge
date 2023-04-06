# frozen_string_literal: true

module REST
  class API
    class Courses
      class Create < Base
        class Contract < Dry::Validation::Contract
          json do
            required(:name).filled(Types::Name)
            required(:content).filled(Types::String)
            required(:author_id).filled(Types::ID::Public)
          end
        end

        desc "Create a course"
        post do
          validate!(params, with: Contract) => { content:, author_id:, name: }
          status = ::Types::LearningMaterial::Status::DRAFT
          ::Talent
            .find_by_public_id(author_id)
            .tap { |author| not_found!(:author_id) if author.nil? }
            .then { |author| ::Types::Course::Properties.new(content:, name:, author:, status:) }
            .then { |properties| ::Course.save!(properties) }
            .then { |entity| present entity, with: Serialization::Course }
        rescue ::Course::NameDuplicationError
          validation_error!(:name, I18n.t("rest.errors.already_taken"))
        end
      end
    end
  end
end
