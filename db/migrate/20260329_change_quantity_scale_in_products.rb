class ChangeQuantityScaleInProducts < ActiveRecord::Migration[8.0]
  def change
    change_column :products, :quantity, :decimal, precision: 8, scale: 3
  end
end
