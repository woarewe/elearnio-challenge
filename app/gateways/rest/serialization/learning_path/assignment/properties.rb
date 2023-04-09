# frozen_string_literal: true

module REST
  module Serialization
    class LearningPath
      class Assignment
        class Properties < Base
          expose :talent, using: Talent
          expose :learning_path, using: LearningPath
        end
      end
    end
  end
end
