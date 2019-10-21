class AddAbsentAlertToClubs < ActiveRecord::Migration[5.0]
  def change
    add_column :clubs, :absent_alert, :integer
  end
end
