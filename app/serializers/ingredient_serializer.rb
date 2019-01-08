class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :category
  has_many :recipes
  has_many :meals, through: :recipes
end
