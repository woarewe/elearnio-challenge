# frozen_string_literal: true

class CreateLearningPaths < ActiveRecord::Migration[6.1]
  include DB::MigrationHelper

  def change
    create_table :learning_paths do |t|
      uuid_column(t, :public_id)
      t.string :name, index: { unique: true }, null: false
      t.bigint :author_id, index: true, null: false
      t.string :status, null: false

      t.timestamps
    end

    add_foreign_key :learning_paths, :talents, column: :author_id

    create_table :learning_path_slots do |t|
      t.bigint :course_id, null: false
      t.bigint :learning_path_id, null: false
      t.integer :position, null: false

      t.timestamps
    end

    add_foreign_key :learning_path_slots, :learning_paths
    add_foreign_key :learning_path_slots, :courses

    add_index :learning_path_slots, [:learning_path_id, :course_id], unique: true
    add_index :learning_path_slots, :course_id
  end
end
