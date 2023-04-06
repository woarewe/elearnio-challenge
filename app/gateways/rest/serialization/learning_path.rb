# frozen_string_literal: true

module REST
  module Serialization
    class LearningPath < Base
      include WithPublicID
      include WithTimestamps

      expose :properties, using: Properties
    end
  end
end
