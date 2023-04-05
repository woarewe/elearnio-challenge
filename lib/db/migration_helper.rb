# frozen_string_literal: true

module DB
  module MigrationHelper
    def uuid_column(table, name)
      table.uuid name, null: false, index: { unique: true }, default: "gen_random_uuid()"
    end
  end
end
