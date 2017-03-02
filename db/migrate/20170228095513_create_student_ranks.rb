class CreateStudentRanks < ActiveRecord::Migration[5.0]
  def change
    create_table :student_ranks do |t|
      t.references :student, foreign_key: true
      t.references :rank, foreign_key: true

      t.timestamps
    end
  end
end
