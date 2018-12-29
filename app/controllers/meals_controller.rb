class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :update, :destroy]

  #GET /meals/list
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
    if params[:page]
      @meals = Meal.page(params[:page][:number]).per(params[:page][:size])
    else
      @meals = Meal.all
    end
    if !(params[:category].empty?)
      @meals = @meals.where(category: params[:category]);
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
      render json: @meal.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /meals/1
  def update
    if @meal.update(meal_params)
      render json: @meal
    else
      render json: @meal.errors, status: :unprocessable_entity
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
      params.require(:meal).permit(:name, :notes, :serves)
    end
end
