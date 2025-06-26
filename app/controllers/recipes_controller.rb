class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = current_user.recipes
    
    # Filter by cuisine if specified
    @recipes = @recipes.by_cuisine(params[:cuisine]) if params[:cuisine].present?
    
    # Filter by occasion if specified
    @recipes = @recipes.by_occasion(params[:occasion]) if params[:occasion].present?
    
    # Filter by difficulty if specified
    @recipes = @recipes.by_difficulty(params[:difficulty]) if params[:difficulty].present?
    
    # Search by name if specified
    @recipes = @recipes.where("name ILIKE ?", "%#{params[:search]}%") if params[:search].present?
    
    @cuisines = Recipe::CUISINES
    @occasions = Recipe::OCCASIONS
    @difficulties = Recipe::DIFFICULTIES
  end

  def show
  end

  def new
    @recipe = current_user.recipes.build
    @cuisines = Recipe::CUISINES
    @difficulties = Recipe::DIFFICULTIES
    @occasions = Recipe::OCCASIONS
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      @cuisines = Recipe::CUISINES
      @difficulties = Recipe::DIFFICULTIES
      @occasions = Recipe::OCCASIONS
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @cuisines = Recipe::CUISINES
    @difficulties = Recipe::DIFFICULTIES
    @occasions = Recipe::OCCASIONS
  end

  def update
    # Handle image removal
    if params[:recipe][:remove_image] == "1"
      @recipe.image.purge if @recipe.image.attached?
    end
    
    if @recipe.update(recipe_params.except(:remove_image))
      redirect_to @recipe, notice: 'Recipe was successfully updated.'
    else
      @cuisines = Recipe::CUISINES
      @difficulties = Recipe::DIFFICULTIES
      @occasions = Recipe::OCCASIONS
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_url, notice: 'Recipe was successfully deleted.'
  end

  private

  def set_recipe
    @recipe = current_user.recipes.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :cuisine, :difficulty, :prep_time, :cook_time, :servings, :instructions, :ingredients, :occasion, :image)
  end
end 