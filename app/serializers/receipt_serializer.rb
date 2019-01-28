class ReceiptSerializer < ActiveModel::Serializer
  attributes :id, :location, :cost, :notes
  has_one :week
end
