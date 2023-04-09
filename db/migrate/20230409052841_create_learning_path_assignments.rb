# frozen_string_literal: true

class CreateLearningPathAssignments < ActiveRecord::Migration[6.1]
  include DB::MigrationHelper

  def change
    create_table :learning_path_assignments do |t|
      uuid_column(t, :public_id)
      t.bigint :learning_path_id, null: false
      t.bigint :talent_id, null: false

      t.timestamps
    end

    add_foreign_key :learning_path_assignments, :talents
    add_foreign_key :learning_path_assignments, :learning_paths

    add_index :learning_path_assignments, [:learning_path_id, :talent_id], unique: true,
                                                                           name: "learning_path_assignments_uniq"
    add_index :learning_path_assignments, :talent_id
  end
end
