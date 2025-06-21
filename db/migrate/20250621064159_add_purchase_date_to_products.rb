class AddPurchaseDateToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :purchase_date, :date
  end
end
