class Ingredient < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :meals, through: :recipes

  validates_presence_of :name
  validates_presence_of :location

  validates_uniqueness_of :name

  enum location: [:walmart, :aldi, :other]
  enum category: [:meat, :dairy, :frozen_goods, :sauce, :seasoning, :dry_goods, :na]

  scope :location, -> (location) {where location: location}
  scope :category, -> (category) {where category: category}

end
