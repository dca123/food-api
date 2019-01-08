class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :location
      t.integer :category
      t.timestamps
    end
    add_index :ingredients, [:name], unique: true
  end
end
