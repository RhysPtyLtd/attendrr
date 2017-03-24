class AddActiveToStudentRanks < ActiveRecord::Migration[5.0]
  def change
    add_column :student_ranks, :active, :boolean
  end
end
