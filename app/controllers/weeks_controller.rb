class WeeksController < ApplicationController
  before_action :set_week, only: [:show, :update, :destroy]

  def shopping_list
    @week = Week.find(params[:id])
    servingSize = params[:servingSize].to_f
    shoppingList = Hash.new
    Ingredient.locations.each_key do |location|
      shoppingList[location] = Hash.new
      Ingredient.categories.each_key do |key|
        shoppingList[location][key] = Hash.new
      end
    end
    @week.menus.each do |menu|
      meal = menu.meal
      multiplier = servingSize/meal.serves
      puts multiplier
      meal.recipes.each do |recipe|
        ingredient = recipe.ingredient
        if shoppingList[ingredient.location][ingredient.category].key?(ingredient.name)
          added = false
          shoppingList[ingredient.location][ingredient.category][ingredient.name].each do |quant|
            if quant[:measure] == recipe.measure
              quant[:quantity] += recipe.quantity * multiplier
              added = true
            end
          end
          if !added
            data = Hash.new
            data[:quantity] = recipe.quantity * multiplier
            data[:measure] = recipe.measure
            data[:notes] = recipe.notes
            shoppingList[ingredient.location][ingredient.category][ingredient.name].push(data)
          end
        else
          shoppingList[ingredient.location][ingredient.category][ingredient.name] = []
          data = Hash.new
          data[:quantity] = recipe.quantity * multiplier
          data[:measure] = recipe.measure
          data[:notes] = recipe.notes
          shoppingList[ingredient.location][ingredient.category][ingredient.name].push(data)
        end
        shoppingList[ingredient.location][ingredient.category] = shoppingList[ingredient.location][ingredient.category].sort.to_h
      end
    end
    render json: shoppingList
  end

  def list
    years = Week.distinct.pluck(:year).map(&:to_s)
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
    if params[:include]
      render json: @week, include: ['receipts']
    else
      render json: @week
    end
  end

  # POST /weeks
  def create
    @week = Week.new(week_params)

    if @week.save
      render json: @week, status: :created, location: @week
    else
      @correct_week = Week.week_of(week_params[:week_of], week_params[:month], week_params[:year])
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
