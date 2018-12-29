class Week < ApplicationRecord
  has_many :menus, dependent: :destroy
  scope :month, ->(month) {where month: month}
  scope :year, ->(year) {where year: year}
end
