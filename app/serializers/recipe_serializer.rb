class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :meal_id, :ingredient_id, :quantity, :measure, :notes
  belongs_to :meal
  belongs_to :ingredient
end
