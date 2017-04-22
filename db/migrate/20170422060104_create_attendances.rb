class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.references :student, foreign_key: true
      t.references :activity, foreign_key: true
      t.references :timeslot, foreign_key: true
      t.datetime :attended_on

      t.timestamps
    end
  end
end
