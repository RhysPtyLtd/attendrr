class AddStudentSinceToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :student_since, :date
  end
end
