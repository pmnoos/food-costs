class AddFieldsToMenus < ActiveRecord::Migration[8.0]
  def change
    add_column :menus, :cuisine, :string
    add_column :menus, :servings, :integer
    add_column :menus, :description, :text
  end
end
