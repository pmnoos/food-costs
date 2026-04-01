class ReportsController < ApplicationController
  def index
    @weekly_total = Product.where(created_at: Time.now.all_week).sum(:total_cost)
    @monthly_total = Product.where(created_at: Time.now.all_month).sum(:total_cost)
    @yearly_total = Product.where(created_at: Time.now.all_year).sum(:total_cost)

    # For price history
    @product_names = Product.distinct.order(:name).pluck(:name)
    @selected_product_name = params[:product_name]
    if @selected_product_name.present?
      @product_price_history = Product.where(name: @selected_product_name).order(purchase_date: :desc, created_at: :desc)
    else
      @product_price_history = []
    end
  end
end
