# frozen_string_literal: true

class CreateCourseAssignments < ActiveRecord::Migration[6.1]
  include DB::MigrationHelper

  def change
    create_table :course_assignments do |t|
      uuid_column(t, :public_id)
      t.bigint :talent_id, null: false
      t.string :status, null: false
      t.bigint :course_id, null: false

      t.timestamps
    end

    add_foreign_key :course_assignments, :talents
    add_foreign_key :course_assignments, :courses

    add_index :course_assignments, [:talent_id, :course_id], unique: true
    add_index :course_assignments, :course_id
  end
end
