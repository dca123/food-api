class ReceiptMailer < ApplicationMailer
  default from: "receipts@food.devinda.me"

  def receipt_email(receipt)
    @receipt = receipt
    @today = Date.today.strftime("%m/%d/%Y")
    mail(to: Settings.treasurer, subject: "Food Receipt at #{@receipt.location.capitalize} for $#{@receipt.cost} - #{@today}")
  end
  def delete_email(receipt)
    @receipt = receipt
    @today = Date.today.strftime("%m/%d/%Y")
    mail(to: Settings.treasurer, subject: "Removed Food Receipt at #{@receipt.location.capitalize} for $#{@receipt.cost} - #{@today}")
  end
end
