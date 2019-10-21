class AddDefaultValueToAbsentAlertInClubs < ActiveRecord::Migration[5.0]
  def change
  	change_column :clubs, :absent_alert, :integer, :default => 14
  end
end
