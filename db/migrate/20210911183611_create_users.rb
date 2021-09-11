class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: false do |t|
      t.primary_key :user_id
      t.string :session_token
      t.string :device_id, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :users, :session_token, unique: true, null_filtered: true
    add_index :users, :device_id, unique: true
  end
end
