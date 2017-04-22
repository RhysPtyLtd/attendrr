class AddAttendedToAttendance < ActiveRecord::Migration[5.0]
  def change
    add_column :attendances, :attended, :boolean
  end
end
