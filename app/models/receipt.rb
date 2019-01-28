class Receipt < ApplicationRecord
  belongs_to :week

  validates_presence_of :location
  validates_presence_of :cost
  validates_numericality_of :cost, { greater_than: 0, less_than: 10000, message: "must be less that $9999.99"}

  enum location: Settings.ingredient.location

  scope :week, ->(week_id) {where week_id: week_id}
end
