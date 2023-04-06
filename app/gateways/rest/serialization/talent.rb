# frozen_string_literal: true

module REST
  module Serialization
    class Talent < Base
      include WithPublicID
      include WithTimestamps
      include WithProperties
    end
  end
end
