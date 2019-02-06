class AddSemesterToWeeks < ActiveRecord::Migration[5.2]
  def change
    add_reference :weeks, :semester, foreign_key: true
  end
end
