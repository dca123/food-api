class Receipt < ApplicationRecord
  belongs_to :week
  enum location: Settings.ingredient.location
end
