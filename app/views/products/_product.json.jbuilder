json.extract! product, :id, :name, :unit, :unit_price, :quantity, :total_cost, :store_id, :created_at, :updated_at
json.url product_url(product, format: :json)
