class AddClassesRemainingToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :classes_remaining, :integer
  end
end
