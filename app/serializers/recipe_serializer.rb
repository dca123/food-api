class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :meal_id, :ingredient_id, :quantity, :measure
end
