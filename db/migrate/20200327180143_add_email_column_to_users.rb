class AddEmailColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email, :string, null: false, default: 'noemail@stuff.com'
  end
end
