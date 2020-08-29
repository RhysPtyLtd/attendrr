class ChangeDateFormatInTimeslots < ActiveRecord::Migration[5.2]
  
  def change
    reversible do |dir|
      change_table :timeslots do |t|
        dir.up   { 
      		t.change :time_start, :datetime
      		t.change :time_end, :datetime
        }
        dir.down { 
        	t.change :time_start, :time
      		t.change :time_end, :time
        }
      end
    end
  end
end
