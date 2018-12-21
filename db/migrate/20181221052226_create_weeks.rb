class CreateWeeks < ActiveRecord::Migration[5.2]
  def change
    create_table :weeks do |t|
      t.integer :weekOf
      t.integer :year
      t.integer :month
      t.decimal :cost, precision: 6, scale: 2

      t.timestamps
    end
    add_index :weeks, [:weekOf, :year], unique: true
    add_index :weeks, :weekOf
    add_index :weeks, :month
    add_index :weeks, :year
  end
end
