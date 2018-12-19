class MealSerializer < ActiveModel::Serializer
  attributes :id, :name, :notes, :serves
end
