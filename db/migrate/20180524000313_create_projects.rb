class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :compensation_amount
      t.string :internal_name
      t.integer :interview_type
      t.string :public_title
      t.integer :requested_participants

      t.datetime :charged_at
      t.datetime :launched_at

      t.integer :user_id

      t.timestamps null: false
    end

    add_index :projects, :user_id
    add_foreign_key :projects, :users
  end
end
