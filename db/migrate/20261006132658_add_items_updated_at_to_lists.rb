class AddItemsUpdatedAtToLists < ActiveRecord::Migration[8.1]
  def change
    add_column :lists, :items_updated_at, :datetime
  end
end
