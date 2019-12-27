class CreateDailyMetrics < ActiveRecord::Migration[5.2]
  def change
    create_table :daily_metrics do |t|
      t.integer :total_active_students
      t.integer :lost_students
      t.integer :new_students
      t.references :club, foreign_key: true

      t.timestamps
    end
  end
end
