class Menu < ApplicationRecord
  belongs_to :week
  belongs_to :meal
  has_many :ingredients, through: :meal
  has_many :recipes, through: :meal

  validates_uniqueness_of :meal_id, scope: [:week_id, :day, :meal_time]

  enum day: Settings.days
  enum meal_time: Settings.meal_time

  scope :week, ->(week_id) {where week_id: week_id}
end
