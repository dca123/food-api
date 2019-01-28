class Week < ApplicationRecord
  has_many :menus, dependent: :destroy
  has_many :receipts, dependent: :destroy
  scope :month, ->(month) {where month: month}
  scope :year, ->(year) {where year: year}
  scope :week_of, ->(week_of, month, year) {where week_of: week_of, month: month, year: year}
  validates_uniqueness_of :week_of, scope: :year, message: 'This week already exists, Would you like to edit it instead ?'
end
