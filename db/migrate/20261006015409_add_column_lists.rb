class AddColumnLists < ActiveRecord::Migration[8.1]
  def change
    add_column :lists, :is_completed, :boolean, default: false, null: false
  end
end
