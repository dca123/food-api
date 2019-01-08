class ReceiptSerializer < ActiveModel::Serializer
  attributes :id, :location, :cost, :cost, :notes
  has_one :week
end
