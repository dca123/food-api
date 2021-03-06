class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :update, :destroy]

  def category
    list = Meal.categories.keys.sort
    render json: list
  end

  #GET List of meals by category
  def list
    categories = Meal.distinct.pluck(:category)
    meal_list = []
    categories.each { |category|
      obj = {
        groupName: category.capitalize,
        options: Meal.where(category: category).select(:id, :name)
      }
      meal_list.push(obj)
    }

    render json: meal_list
  end
  # GET /meals
  def index
    @meals = Meal.where(nil)
    @meals = @meals.category(params[:category]) if params[:category].present?
    if params[:page]
      @meals = @meals.page(params[:page][:number]).per(params[:page][:size])
    else
      @meals = @meals.all
    end
    render json: @meals
  end

  # GET /meals/1
  def show
    render json: @meal, include: ['recipes', 'ingredients']
  end

  # POST /meals
  def create
    @meal = Meal.new(meal_params)

    if @meal.save
      render json: @meal, status: :created, location: @meal
    else
      render json: error_jsonapi(@meal), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /meals/1
  def update
    if @meal.update(meal_params)
      render json: @meal
    else
      render json: error_jsonapi(@meal), status: :unprocessable_entity
    end
  end

  # DELETE /meals/1
  def destroy
    @meal.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def meal_params
      ActiveModelSerializers::Deserialization.jsonapi_parse!(params, only: [:name, :notes, :category, :serves])
    end
end
