class AddUniqueIDtoWeeks < ActiveRecord::Migration[5.2]
  def change
    add_index :weeks, [:week_of, :month, :semester_id], unique: true
  end
end
