# frozen_string_literal: true

module REST
  class API
    class LearningPaths
      class Assignments < Base
        helpers(
          Helpers::LearningPaths::Assignments,
          Helpers::LearningMaterials::Assignments
        )

        mount Create
      end
    end
  end
end
