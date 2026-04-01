class ProductPriceHistoryController < ApplicationController
  def index
    @product_names = Product.distinct.order(:name).pluck(:name)
    @selected_product_name = params[:product_name]
    @filter = params[:filter] || "all"
    if @selected_product_name.present?
      products = Product.where(name: @selected_product_name).order(purchase_date: :asc, created_at: :asc)
      case @filter
      when "monthly"
        @grouped_history = products.group_by { |p| p.purchase_date&.strftime("%Y-%m") || p.created_at.strftime("%Y-%m") }
      when "yearly"
        @grouped_history = products.group_by { |p| p.purchase_date&.year || p.created_at.year }
      else
        @grouped_history = { "All" => products }
      end
    else
      @grouped_history = {}
    end
  end
end
