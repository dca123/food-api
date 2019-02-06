class Week < ApplicationRecord
  has_many :menus, dependent: :destroy
  has_many :receipts, dependent: :destroy
  belongs_to :semester
  scope :month, ->(month) {where month: month}
  scope :week_of, ->(week_of, semester_id) {where week_of: week_of, semester_id: semester_id }
  # validates_uniqueness_of :week_of, scope: :semester_id, message: 'This week already exists, Would you like to edit it instead ?'
  def cost
    self.receipts.pluck(:cost).sum
  end
  def year
    self.semester.start.year
  end
end
