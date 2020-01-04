class AddRevenueToDailyMetrics < ActiveRecord::Migration[5.2]
  def change
    add_column :daily_metrics, :revenue, :float
  end
end
