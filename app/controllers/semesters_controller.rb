class SemestersController < ApplicationController
  before_action :set_semester, only: [:show, :update, :destroy]

  def list
    years = Semester.pluck(:start).map(&:year).uniq
    render json: years
  end

  # GET /semesters
  def index
    @semesters = Semester.all

    render json: @semesters.order(start: :desc)
  end

  # GET /semesters/1
  def show
    render json: @semester, include: [:weeks]
  end

  # POST /semesters
  def create
    if !Semester.current
      semester_params[:start] = Date.parse(semester_params[:start]).beginning_of_week if semester_params[:start].present?
      semester_params[:end] =  Date.parse(semester_params[:end]).end_of_week if semester_params[:end].present?
      @semester = Semester.new(semester_params)
      if @semester.save
        render json: @semester, status: :created, location: @semester
      else
        render json: error_jsonapi(@semester), status: :unprocessable_entity
      end
    else
      render json: {errors: [0, Semester.current.id, "There is a current Semester in use, would you like to edit that instead ?"]}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /semesters/1
  def update
    if @semester.update(semester_params)
      render json: @semester
    else
      render json: @semester.errors, status: :unprocessable_entity
    end
  end

  # DELETE /semesters/1
  def destroy
    @semester.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_semester
      @semester = Semester.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def semester_params
      ActiveModelSerializers::Deserialization.jsonapi_parse!(params, only: [:name, :budget, :start, :end, :spring] )
    end
end
