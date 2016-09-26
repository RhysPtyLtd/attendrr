class CreateTimeslots < ActiveRecord::Migration[5.0]
  def change
    create_table :timeslots do |t|
      t.time :time_start
      t.time :time_end
      t.integer :day
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end
