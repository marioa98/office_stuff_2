class AddColumnsToStuffs < ActiveRecord::Migration[6.0]
  def change
    create_table :stuffs do |t|
      t.belongs_to :user
      t.belongs_to :category
      t.string :stuff_name, null: false
      t.integer :status, default: 0
      
      t.timestamps
    end
  end
end
