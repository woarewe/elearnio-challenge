# frozen_string_literal: true

class CreateTalents < ActiveRecord::Migration[6.1]
  include DB::MigrationHelper

  def change
    create_table :talents do |t|
      uuid_column(t, :public_id)

      t.string :email, null: false, index: { unique: true }
      t.string :first_name, null: false
      t.string :last_name, null: false

      t.timestamps
    end
  end
end
