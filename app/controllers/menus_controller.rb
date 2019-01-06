class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :update, :destroy]

  # GET /menus
  def index
    @menus = Menu.where(nil)
    if params[:week]
      @menus = Menu.week(params[:week])
    else
      @menus = Menu.all
    end
    render json: @menus, include: ['meal']
  end

  # GET /menus/1
  def show
    puts params

    render json: @menu
  end

  # POST /menus
  def create
    @menu = Menu.new(menu_params)

    if @menu.save
      render json: @menu, status: :created, location: @menu
    else
      render json: {errors: [@menu.errors]}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /menus/1
  def update
    if @menu.update(menu_params)
      render json: @menu
    else
      render json: @menu.errors, status: :unprocessable_entity
    end
  end

  # DELETE /menus/1
  def destroy
    week = Week.find(@menu.week_id)
    @menu.destroy
    unless week.menus.any?
      week.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def menu_params
      ActiveModelSerializers::Deserialization.jsonapi_parse!(params, only: [:week, :day, :meal_time, :meal] )
    end
end
