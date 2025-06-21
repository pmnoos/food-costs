class ReportsController < ApplicationController
  def index
    @weekly_total = Product.where(created_at: Time.now.all_week).sum(:total_cost)
    @monthly_total = Product.where(created_at: Time.now.all_month).sum(:total_cost)
    @yearly_total = Product.where(created_at: Time.now.all_year).sum(:total_cost)
  end
end
