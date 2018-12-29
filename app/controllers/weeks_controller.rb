class WeeksController < ApplicationController
  before_action :set_week, only: [:show, :update, :destroy]

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
      render json: @week.errors, status: :unprocessable_entity
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
