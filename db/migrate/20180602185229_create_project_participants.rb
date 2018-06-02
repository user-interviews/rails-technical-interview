class CreateProjectParticipants < ActiveRecord::Migration
  def change
    create_table :project_participants do |t|
      t.integer :project_id, null: false
      t.integer :participant_id, null: false

      t.datetime :approved_at

      t.timestamps null: false
    end

    add_index :project_participants, :participant_id
    add_index :project_participants, :project_id

    add_index :project_participants, [:participant_id, :project_id], unique: true
  end
end
