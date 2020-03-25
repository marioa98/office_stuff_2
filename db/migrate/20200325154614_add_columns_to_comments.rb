class AddColumnsToComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :stuff
      t.string :comment

      t.timestamps
    end
  end
end
