class Menu < ApplicationRecord
  belongs_to :week
  belongs_to :meal
  enum day: [:monday, :tuesday, :wednesday, :thursday, :friday]
  enum mealTime: [:lunch, :dinner]
end
