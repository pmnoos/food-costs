class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :set_stores, only: %i[ index new create edit update ]

  # GET /products or /products.json
  def index
    base_scope = products_scope.includes(:store)
    @product_names = base_scope.where.not(name: [ nil, "" ]).distinct.order(:name).pluck(:name)
    @products = base_scope.order(purchase_date: :desc, created_at: :desc)

    if params[:name].present?
      @products = @products.where("products.name ILIKE ?", "%#{params[:name]}%")
    end

    # Apply filters
    if params[:store_id].present?
      @products = @products.where(store_id: params[:store_id])
    end

    if params[:purchase_date].present?
      @products = @products.where(purchase_date: params[:purchase_date])
    end

    # Pagination (12 per page)
    @products = @products.page(params[:page]).per(12)
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new

    # Set default values from session or params
    default_store_id = session[:last_store_id] || params[:store_id]
    @product.store_id = @stores.exists?(id: default_store_id) ? default_store_id : nil
    @product.purchase_date = session[:last_purchase_date] || params[:purchase_date] || Date.current
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(scoped_product_attributes)

    respond_to do |format|
      if @product.save
        # Remember the store and date for next product
        session[:last_store_id] = @product.store_id
        session[:last_purchase_date] = @product.purchase_date

        format.html { redirect_to new_product_path, notice: "Product was successfully created. Add another product below." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(scoped_product_attributes)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, status: :see_other, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /products/autocomplete.json
  def autocomplete
    products = if params[:term].present?
      products_scope.where("LOWER(products.name) LIKE ?", "%#{params[:term].downcase}%")
    else
      products_scope
    end
    products = products.order(updated_at: :desc).limit(50)
    render json: products.map { |p| {
      id: p.id,
      name: p.name,
      store_id: p.store_id,
      unit: p.unit,
      quantity: p.quantity,
      unit_price: p.unit_price,
      total_cost: p.total_cost,
      purchase_date: p.purchase_date
    } }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = products_scope.includes(:store).find(params[:id])
    end

    def set_stores
      @stores = current_user.stores.order(:name)
    end

    def products_scope
      Product.joins(:store).where(stores: { user_id: current_user.id })
    end

    def scoped_product_attributes
      attributes = product_params.except(:store_id)

      if product_params[:store_id].present?
        attributes[:store] = @stores.find_by(id: product_params[:store_id])
      end

      attributes
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :purchase_date, :unit, :unit_price, :quantity, :total_cost, :store_id)
    end
end
