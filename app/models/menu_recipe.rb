class MenuRecipe < ApplicationRecord
  belongs_to :menu
  belongs_to :recipe

  validates :menu_id, uniqueness: { scope: :recipe_id }
end 