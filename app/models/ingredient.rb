class Ingredient < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :meals, through: :recipes

  validates_presence_of :name
  validates_presence_of :location

  validates_uniqueness_of :name

  enum location: Settings.ingredient.location
  enum category: Settings.ingredient.category

  scope :location, -> (location) {where location: location}
  scope :category, -> (category) {where category: category}

end
