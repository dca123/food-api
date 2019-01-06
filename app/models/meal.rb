class Meal < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :ingredients, through: :recipes

  validates_presence_of :name
  validates_presence_of :serves

  validates_uniqueness_of :name

  enum category: [:chicken, :beef, :fish, :pork, :vegetables, :dessert, :na]
  scope :category, -> (category) { where category: category}

end
