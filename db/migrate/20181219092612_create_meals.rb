class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.string :name
      t.string :notes
      t.integer :serves
      t.integer :category
      
      t.timestamps
    end
    add_index :meals, [:name], unique: true
  end
end
