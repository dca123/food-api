class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.references :week, foreign_key: true
      t.integer :day
      t.integer :meal_time
      t.references :meal, foreign_key: true

      t.timestamps
    end
    add_index :menus, [:week_id, :day, :meal_time, :meal_id ], unique: true
  end
end
