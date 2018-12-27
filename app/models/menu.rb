class Menu < ApplicationRecord
  belongs_to :week
  belongs_to :meal
  has_many :ingredients, through: :meal
  has_many :recipes, through: :meal

  enum day: [:monday, :tuesday, :wednesday, :thursday, :friday]
  enum mealTime: [:lunch, :dinner]
end
