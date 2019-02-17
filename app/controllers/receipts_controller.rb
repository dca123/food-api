class ReceiptsController < ApplicationController
  before_action :set_receipt, only: [:show, :update, :destroy]

  # GET /receipts
  def index
    @receipts = Receipt.all
    render json: @receipts, include: ['week']
  end

  # GET /receipts/1
  def show
    render json: @receipt
  end

  # POST /receipts
  def create
    @receipt = Receipt.new(receipt_params)

    if @receipt.save
      ReceiptMailer.receipt_email(@receipt).deliver_later
      render json: @receipt, status: :created, location: @receipt
    else
      render json: error_jsonapi(@receipt), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /receipts/1
  def update
    if @receipt.update(receipt_params)
      render json: @receipt
    else
      render json: @receipt.errors, status: :unprocessable_entity
    end
  end

  # DELETE /receipts/1
  def destroy
    ReceiptMailer.delete_email(@receipt).deliver_now
    if @receipt.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_receipt
      @receipt = Receipt.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def receipt_params
      ActiveModelSerializers::Deserialization.jsonapi_parse!(params, only: [:week, :location, :cost, :notes])
    end
end
