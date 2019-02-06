class Meal < ApplicationRecord
  attribute :recent
  has_many :recipes, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :ingredients, through: :recipes

  validates_presence_of :name
  validates_presence_of :serves
  validates_presence_of :category

  validates_uniqueness_of :name

  enum category: Settings.meal.category

  scope :category, -> (category) { where category: category}

  @@recent_meals =  Menu.where(created_at: 2.week.ago.beginning_of_week..1.week.ago.end_of_week).pluck(:meal_id).uniq.to_set
  def recent
    if @@recent_meals.include?(self.id)
      return true
    else
      return false
    end
  end
end
