class Menu < ApplicationRecord
  belongs_to :week
  belongs_to :meal
  has_many :ingredients, through: :meal
  has_many :recipes, through: :meal

  validates_uniqueness_of :meal_id, scope: [:week_id, :day, :meal_time]

  enum day: [:monday, :tuesday, :wednesday, :thursday, :friday]
  enum meal_time: [:lunch, :dinner]

  scope :week, ->(week_id) {where week_id: week_id}
end
