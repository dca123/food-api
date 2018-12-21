class MenuSerializer < ActiveModel::Serializer
  attributes :id, :day, :mealTime
  has_one :week
  has_one :meal
end
