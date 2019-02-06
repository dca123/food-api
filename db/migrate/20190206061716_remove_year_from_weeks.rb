class RemoveYearFromWeeks < ActiveRecord::Migration[5.2]
  def change
    remove_column :weeks, :year, :integer
  end
end
