class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :name, :location
  has_many :recipes
  has_many :meals, through: :recipes
end
