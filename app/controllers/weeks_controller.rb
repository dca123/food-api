class WeeksController < ApplicationController
  before_action :set_week, only: [:show, :update, :destroy]

  def report
    report = Hash.new
    currentSemester = Semester.current
    currentDate = Date.current
    if currentSemester
      report[:usage] = (currentSemester.total.to_f/currentSemester.budget.to_f * 100).round(2)
      semesterWeeks = currentSemester.weeks.order(:id)

      report[:current] = semesterWeeks.last ? semesterWeeks.last.cost : nil
      report[:last] = semesterWeeks.second_to_last ? semesterWeeks.second_to_last.cost : nil
      report[:budget] = currentSemester.budget

      report[:weeksChart] = Hash.new
      report[:weeksChart][:cost] = Array.new
      report[:weeksChart][:label] = Array.new
      semesterWeeks.each do |week|
        report[:weeksChart][:label].push "#{week.week_of}/#{week.month}/#{week.semester.start.year}"
        report[:weeksChart][:cost].push week.cost
      end

      report[:cumalativeChart] = Hash.new
      report[:cumalativeChart][:cost] = Array.new
      report[:cumalativeChart][:label] = Array.new
      semesterWeeks.each_with_index do |week, index|
        report[:cumalativeChart][:label].push "#{week.week_of}/#{week.month}/#{week.semester.start.year}"
        report[:cumalativeChart][:cost].push index == 0 ? week.cost : week.cost + report[:cumalativeChart][:cost][index-1]
      end
    end
    render json: report
  end
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

  # GET /weeks
  def index
    @weeks = Week.where(nil)
    if params[:page]
      @weeks = @weeks.page(params[:page][:number]).per(params[:page][:size])
    end
    @weeks = @weeks.month(params[:month]) if params[:month].present?
    if params[:year].present?
      semesters = Semester.where(start: Date.new(params[:year].to_i,1,1)..Date.new(params[:year].to_i,12,31)).pluck(:id)
      puts semesters
      @weeks = @weeks.where(semester_id: semesters)
    end
    render json: @weeks.order(semester_id: :desc, month: :desc, week_of: :desc)
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
    if !Semester.current #Checks if current Semester is invlid
      render json: {errors: [0, "The current semester doesn't exist, would you like to create one ?"]}, status: :unprocessable_entity
    else
      # @week = Week.new(week_params.merge(semester: Semester.current))
      # if @week.save
      #   render json: @week, status: :created, location: @week
      # else
      #   @correct_week = Week.week_of(week_params[:week_of], Semester.last.id)
      #   puts "correct_week #{@week.errors.to_h}"
      #   render json: {errors: [@week.errors.to_h, {week_id: @correct_week.take.id}]}, status: :unprocessable_entity
      # end
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
      ActiveModelSerializers::Deserialization.jsonapi_parse!(params, only: [:week_of, :month] )
    end
end
