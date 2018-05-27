class CreateProjectAccesses < ActiveRecord::Migration
  def change
    create_table :project_accesses do |t|
      t.integer :project_id
      t.integer :user_id

      t.boolean :owner

      t.timestamps null: false
    end

    add_index :project_accesses, :project_id
    add_foreign_key :project_accesses, :projects

    add_index :project_accesses, :user_id
    add_foreign_key :project_accesses, :users

    add_index :project_accesses, [:project_id, :user_id], unique: true
  end
end
