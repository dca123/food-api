class AddDefaultValueToCostInWeeks < ActiveRecord::Migration[5.2]
  def change
    change_column_default :weeks, :cost, 0
  end
end
