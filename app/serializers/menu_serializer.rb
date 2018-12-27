class MenuSerializer < ActiveModel::Serializer
  attributes :id, :day, :mealTime
  has_one :week
  has_one :meal
  has_many :recipes
  has_many :ingredients
end
