class CreateLists < ActiveRecord::Migration[8.1]
  def change
    create_table :lists do |t|
      t.string :title, null: false
      t.text :memo
      t.integer :category
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
