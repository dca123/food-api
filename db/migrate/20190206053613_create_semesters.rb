class CreateSemesters < ActiveRecord::Migration[5.2]
  def change
    create_table :semesters do |t|
      t.string :name
      t.decimal :budget, precision: 8, scale: 2
      t.boolean :spring
      t.date :start
      t.date :end

      t.timestamps
    end
  end
end
