class AddEnrolledOnToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :enrolled_on, :datetime
  end
end
