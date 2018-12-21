class WeekSerializer < ActiveModel::Serializer
  attributes :id, :weekOf, :year, :month, :cost
end
