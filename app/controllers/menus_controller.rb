class MenusController < ApplicationController
  before_action :authenticate_user!
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  def index
    @menus = current_user.menus.order(date: :desc)
    
    # Filter by occasion if specified
    @menus = @menus.by_occasion(params[:occasion]) if params[:occasion].present?
    
    # Filter by cuisine if specified
    @menus = @menus.joins(:recipes).where(recipes: { cuisine: params[:cuisine] }) if params[:cuisine].present?
    
    # Search by name if specified
    @menus = @menus.where("menus.name ILIKE ?", "%#{params[:search]}%") if params[:search].present?
    
    @occasions = Menu::OCCASIONS
    @cuisines = Recipe::CUISINES
  end

  def show
    @available_recipes = current_user.recipes.where.not(id: @menu.recipe_ids)
  end

  def new
    @menu = current_user.menus.build
    @recipes = current_user.recipes
    @occasions = Menu::OCCASIONS
    @cuisines = Recipe::CUISINES
    @difficulties = Recipe::DIFFICULTIES
  end

  def create
    @menu = current_user.menus.build(menu_params)
    
    if @menu.save
      redirect_to @menu, notice: 'Menu was successfully created.'
    else
      @recipes = current_user.recipes
      @occasions = Menu::OCCASIONS
      @cuisines = Recipe::CUISINES
      @difficulties = Recipe::DIFFICULTIES
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @recipes = current_user.recipes
    @occasions = Menu::OCCASIONS
    @cuisines = Recipe::CUISINES
    @difficulties = Recipe::DIFFICULTIES
  end

  def update
    # Handle image removal
    if params[:menu][:remove_image] == "1"
      @menu.image.purge if @menu.image.attached?
    end
    
    if @menu.update(menu_params)
      redirect_to @menu, notice: 'Menu was successfully updated.'
    else
      @recipes = current_user.recipes
      @occasions = Menu::OCCASIONS
      @cuisines = Recipe::CUISINES
      @difficulties = Recipe::DIFFICULTIES
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @menu.destroy
    redirect_to menus_url, notice: 'Menu was successfully deleted.'
  end

  def add_recipe
    @menu = current_user.menus.find(params[:id])
    @recipe = current_user.recipes.find(params[:recipe_id])
    
    unless @menu.recipes.include?(@recipe)
      @menu.recipes << @recipe
      redirect_to @menu, notice: 'Recipe added to menu successfully.'
    else
      redirect_to @menu, alert: 'Recipe is already in this menu.'
    end
  end

  def remove_recipe
    @menu = current_user.menus.find(params[:id])
    @recipe = current_user.recipes.find(params[:recipe_id])
    
    @menu.recipes.delete(@recipe)
    redirect_to @menu, notice: 'Recipe removed from menu successfully.'
  end

  private

  def set_menu
    @menu = current_user.menus.find(params[:id])
  end

  def menu_params
    params.require(:menu).permit(:name, :occasion, :date, :cuisine, :servings, :description, :image, recipe_ids: [])
  end
end 