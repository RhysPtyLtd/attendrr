class CreateDailyFinancialReports < ActiveRecord::Migration[5.0]
  def change
    create_table :daily_financial_reports do |t|
      t.references :club, foreign_key: true
      t.references :student, foreign_key: true
      t.references :payment_plan, foreign_key: true
      t.decimal :price
      t.string :regularity
      t.float :daily_value
      t.boolean :reccuring

      t.timestamps
    end
  end
end
