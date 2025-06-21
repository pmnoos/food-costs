class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = Product.all
    
    # Apply filters
    if params[:store_id].present?
      @products = @products.where(store_id: params[:store_id])
    end
    
    if params[:purchase_date].present?
      @products = @products.where(purchase_date: params[:purchase_date])
    end
    
    # Get stores for filter dropdown
    @stores = Store.all
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    
    # Set default values from session or params
    @product.store_id = session[:last_store_id] || params[:store_id]
    @product.purchase_date = session[:last_purchase_date] || params[:purchase_date] || Date.current
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

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
      if @product.update(product_params)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.expect(product: [ :name, :purchase_date, :unit, :unit_price, :quantity, :total_cost, :store_id ])
    end
end
