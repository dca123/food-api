class RemoveCostInWeeks < ActiveRecord::Migration[5.2]
  def change
    remove_column :weeks, :cost

  end
end
