class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.references :meal, foreign_key: true
      t.references :ingredient, foreign_key: true
      t.integer :quantity
      t.integer :measure

      t.timestamps
    end
    add_index :recipes, [:meal_id, :ingredient_id], unique: true
  end
end
