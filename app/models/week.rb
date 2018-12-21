class Week < ApplicationRecord
  has_many :menus, dependent: :destroy
end
