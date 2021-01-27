# frozen_string_literal: true

class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.text :first_name
      t.text :last_name
      t.text :email
      t.text :password

      t.integer :rank

      t.timestamps null: false
    end
  end
end
