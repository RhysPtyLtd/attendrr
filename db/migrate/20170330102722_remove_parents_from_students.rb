class RemoveParentsFromStudents < ActiveRecord::Migration[5.0]
  def change
  	remove_column :students, :parent1_first_name, :string
  	remove_column :students, :parent1_last_name, :string
  	remove_column :students, :parent2_first_name, :string
  	remove_column :students, :parent2_last_name, :string
  end
end
