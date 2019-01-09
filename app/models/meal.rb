class Meal < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :ingredients, through: :recipes

  validates_presence_of :name
  validates_presence_of :serves
  validates_presence_of :category

  validates_uniqueness_of :name

  enum category: Settings.meal.category
  
  scope :category, -> (category) { where category: category}

end
