class MealSerializer < ActiveModel::Serializer
  attributes :id, :name, :notes, :serves, :category
  has_many :ingredients
  has_many :recipes
end
