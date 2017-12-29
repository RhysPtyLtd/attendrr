class AddParentsToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :parent1, :string
    add_column :students, :parent2, :string
  end
end
