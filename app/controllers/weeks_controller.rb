class WeeksController < ApplicationController
  before_action :set_week, only: [:show, :update, :destroy]

  def shopping_list
    @week = Week.find(params[:id])
    shoppingList = Hash.new
    Ingredient.locations.each_key do |location|
      shoppingList[location] = Hash.new
    end
    @week.menus.each do |menu|
      menu.meal.recipes.each do |recipe|
        ingredient = recipe.ingredient
        if shoppingList[ingredient.location].key?(ingredient.name)
          shoppingList[ingredient.location][ingredient.name][:quantity] += recipe.quantity
        else
          shoppingList[ingredient.location][ingredient.name] = Hash.new
          shoppingList[ingredient.location][ingredient.name][:quantity] = recipe.quantity
          shoppingList[ingredient.location][ingredient.name][:measure] = recipe.measure
        end
        shoppingList[ingredient.location] = shoppingList[ingredient.location].sort.to_h
      end
    end
    render json: shoppingList
  end

  def list
    years = ['All', Week.distinct.pluck(:year).map(&:to_s)].flatten
    render json: years
  end

  # GET /weeks
  def index
    @weeks = Week.where(nil)
    if params[:page]
      @weeks = @weeks.page(params[:page][:number]).per(params[:page][:size])
    end
    @weeks = @weeks.month(params[:month]) if params[:month].present?
    @weeks = @weeks.year(params[:year]) if params[:year].present?
    render json: @weeks.order(year: :desc, month: :desc, week_of: :desc)
  end

  # GET /weeks/1
  def show
    render json: @week
  end

  # POST /weeks
  def create
    @week = Week.new(week_params)

    if @week.save
      render json: @week, status: :created, location: @week
    else
      @correct_week = Week.week_of(week_params[:week_of], week_params[:month], week_params[:year])
      puts @correct_week
      render json: {errors: [@week.errors.to_h, {week_id: @correct_week.take.id}]}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /weeks/1
  def update
    if @week.update(week_params)
      render json: @week
    else
      render json: @week.errors, status: :unprocessable_entity
    end
  end

  # DELETE /weeks/1
  def destroy
    @week.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_week
      @week = Week.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def week_params
      ActiveModelSerializers::Deserialization.jsonapi_parse!(params, only: [:week_of, :year, :month, :cost] )
    end
end
