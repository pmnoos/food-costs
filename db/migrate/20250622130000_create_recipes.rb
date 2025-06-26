class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.string :cuisine, null: false
      t.string :difficulty, null: false
      t.integer :prep_time
      t.integer :cook_time
      t.integer :servings
      t.text :instructions
      t.text :ingredients
      t.string :occasion
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :recipes, :cuisine
    add_index :recipes, :occasion
    add_index :recipes, :difficulty
  end
end 