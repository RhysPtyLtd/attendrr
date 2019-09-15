class AddRankIdFieldToAttendance < ActiveRecord::Migration[5.0]
  def change
    add_reference :attendances, :rank, index: true
  end
end
