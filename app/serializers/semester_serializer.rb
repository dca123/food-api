class SemesterSerializer < ActiveModel::Serializer
  attributes :id, :name, :budget, :start, :end, :spring, :total
  has_many :weeks
end
