class WeeksController < ApplicationController
  before_action :set_week, only: [:show, :update, :destroy]

  # GET /weeks
  def index
    if params[:page]
      @weeks = Week.order('year DESC, month DESC').page(params[:page][:number]).per(params[:page][:size])
    else
      @weeks = Week.all
    end
    if !(params[:month].empty?)
      @weeks = @weeks.where(month: params[:month]);
      @weeks = @weeks.sort_by { |week| [week.year, week.week_of]}.reverse
    end
    # if !(params[:year].empty?)
    #   @weeks = @weeks.where(year: params[:year]);
    #   @weeks = @weeks.sort_by { |week| [week.month, week.week_of]}.reverse
    # end
    render json: @weeks
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
