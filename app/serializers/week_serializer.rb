class WeekSerializer < ActiveModel::Serializer
  attributes :id, :week_of, :year, :month, :cost
  has_many :menus
end
