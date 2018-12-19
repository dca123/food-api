class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.string :name
      t.string :notes
      t.integer :serves

      t.timestamps
    end
  end
end
