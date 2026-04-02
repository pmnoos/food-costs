class ReportsController < ApplicationController
  def index
    @stores = current_user.stores.order(:name)
    scope = reports_scope

    if params[:name].present?
      scope = scope.where("products.name ILIKE ?", "%#{params[:name]}%")
    end

    if params[:store_id].present?
      scope = scope.where(store_id: params[:store_id])
    end

    if params[:purchase_date].present?
      scope = scope.where(purchase_date: params[:purchase_date])
    end

    @filter_product_names = reports_scope.where.not(name: [ nil, "" ]).distinct.order(:name).pluck(:name)

    @weekly_total = scope.where(purchase_date: Date.current.all_week).sum(:total_cost)
    @monthly_total = scope.where(purchase_date: Date.current.all_month).sum(:total_cost)
    @yearly_total = scope.where(purchase_date: Date.current.all_year).sum(:total_cost)

    # For price history
    @product_names = reports_scope.distinct.order(:name).pluck(:name)
    @selected_product_name = params[:product_name]
    if @selected_product_name.present?
      @product_price_history = reports_scope.where(name: @selected_product_name).order(purchase_date: :desc, created_at: :desc)
    else
      @product_price_history = []
    end
  end

  private

  def reports_scope
    Product.joins(:store).where(stores: { user_id: current_user.id })
  end
end
