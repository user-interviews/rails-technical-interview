class CreateUserRememberTokens < ActiveRecord::Migration
  def change
    create_table :user_remember_tokens do |t|
      t.integer :user_id, null: false
      t.string :token_digest, null: false
      t.datetime :last_used_at, null: false

      t.timestamps null: false
    end

    add_index :user_remember_tokens, [:user_id, :token_digest]
    add_foreign_key :user_remember_tokens, :users
  end
end
