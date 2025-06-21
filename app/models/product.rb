class Product < ApplicationRecord
  belongs_to :store
  
  before_save :calculate_total_cost
  before_save :set_default_purchase_date
  
  private
  
  def calculate_total_cost
    if unit_price.present? && quantity.present?
      self.total_cost = unit_price * quantity
    end
  end
  
  def set_default_purchase_date
    self.purchase_date = Date.current if purchase_date.blank?
  end
end
