class Semester < ApplicationRecord
  has_many :weeks, dependent: :destroy
  #TODO make spring and year unique
  def self.current
    lastRecord = Semester.last
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
end
