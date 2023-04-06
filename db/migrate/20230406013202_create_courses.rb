# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[6.1]
  include DB::MigrationHelper

  def change
    create_table :courses do |t|
      uuid_column(t, :public_id)
      t.string :name, index: { unique: true }, null: false
      t.bigint :author_id, index: true, null: false
      t.string :status, null: false
      t.text :content, null: false

      t.timestamps
    end

    add_foreign_key :courses, :talents, column: :author_id
  end
end
