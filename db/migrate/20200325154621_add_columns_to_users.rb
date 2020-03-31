class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :full_name, null: false
      t.boolean :admin, null: false, default: false
      t.string :email, null: false
      t.string :username, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
