# frozen_string_literal: true

module REST
  class API
    class LearningPaths
      class Publish < Base
        desc "Publish a learning path"
        patch :publish do
          learning_path = find_requested_learning_path!
          learning_path
            .publish!
            .then { |entity| ::LearningPath.save!(entity) }
            .then { |entity| present entity, with: Serialization::LearningPath }
        rescue ::Types::LearningPath::AlreadyPublishedError
          validation_error!(:name,
                            I18n.t("rest.learning_materials.errors.already_published", material: "learning path"))
        end
      end
    end
  end
end
