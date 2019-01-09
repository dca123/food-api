class Recipe < ApplicationRecord
  belongs_to :meal
  belongs_to :ingredient

  validates_presence_of :meal_id
  validates_presence_of :ingredient_id
  validates_numericality_of :quantity

  validates_uniqueness_of :ingredient_id, scope: :meal_id

  enum measure: Settings.units
end
