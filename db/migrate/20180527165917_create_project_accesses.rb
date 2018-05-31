class CreateProjectAccesses < ActiveRecord::Migration
  def change
    create_table :project_accesses do |t|
      t.integer :project_id
      t.integer :user_id

      t.boolean :owner

      t.timestamps null: false
    end
  end
end
