class Semester < ApplicationRecord
  has_many :weeks, dependent: :destroy
  validates_numericality_of :budget, { greater_than: 0, message: "must be greater than $0 !"}
  validates_presence_of :budget
  validates_presence_of :name
  validates_presence_of :start
  validates_presence_of :end
  validates_presence_of :spring, message: ' / Fall cannot be blank !'


  #TODO make spring and year unique
  def self.current
    lastRecord = Semester.first
    return lastRecord
    currentDate = Date.current
    if lastRecord && (lastRecord.start.year == currentDate.year) && ((lastRecord.spring? && currentDate.month >=1 && currentDate.month <=5) ||  (!lastRecord.spring? && currentDate.month >=8 && currentDate.month <=12))
      Semester.last
    else
      false
    end
  end
  def total
    self.weeks.map(&:cost).sum
  end
  def year
    self.start.year
  end
end
