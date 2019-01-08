class CreateReceipts < ActiveRecord::Migration[5.2]
  def change
    create_table :receipts do |t|
      t.references :week, foreign_key: true
      t.integer :location
      t.decimal :cost, precision: 6, scale: 2
      t.string :notes

      t.timestamps
    end
  end
end
