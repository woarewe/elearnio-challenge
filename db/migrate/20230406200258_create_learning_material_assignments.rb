# frozen_string_literal: true

class CreateLearningMaterialAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :learning_material_assignments do |t|
      t.bigint :talent_id, null: false
      t.string :learning_material_type, null: false
      t.bigint :learning_material_id, null: false
      t.string :status, null: false
      t.jsonb :info, null: false

      t.timestamps
    end

    add_foreign_key :learning_material_assignments, :talents

    add_index :learning_material_assignments, [:talent_id, :learning_material_id, :learning_material_type],
              unique: true, name: "learning_material_assigments_uniq"
  end
end
