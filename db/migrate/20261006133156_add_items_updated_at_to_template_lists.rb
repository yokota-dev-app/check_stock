class AddItemsUpdatedAtToTemplateLists < ActiveRecord::Migration[8.1]
  def change
    add_column :template_lists, :items_updated_at, :datetime
  end
end
