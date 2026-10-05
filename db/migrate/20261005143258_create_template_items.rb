class CreateTemplateItems < ActiveRecord::Migration[8.1]
  def change
    create_table :template_items do |t|
      t.string :name, null: false
      t.boolean :is_checked, default: false, null: false
      t.references :template_list, foreign_key: true

      t.timestamps
    end
  end
end
