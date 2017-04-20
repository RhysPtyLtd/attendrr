class AddYearToTimeslot < ActiveRecord::Migration[5.0]
  def change
    add_column :timeslots, :schedule, :datetime
  end
end
