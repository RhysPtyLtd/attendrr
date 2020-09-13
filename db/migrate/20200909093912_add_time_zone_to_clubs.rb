class AddTimeZoneToClubs < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :time_zone, :string, :limit => 255, :default => "UTC"
  end
end
