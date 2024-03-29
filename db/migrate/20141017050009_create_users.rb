class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string "email", null: false
      t.string "password_digest"
      t.string "username"
      t.string "session_token"
      t.string "first_name"
      t.string "last_name"
      t.timestamps
    end
  end
end
