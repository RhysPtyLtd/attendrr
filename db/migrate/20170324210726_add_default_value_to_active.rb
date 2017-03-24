class AddDefaultValueToActive < ActiveRecord::Migration[5.0]
  def change
  	change_column :student_ranks, :active, :boolean, :default => true
  end
end
