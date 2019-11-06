class AddDailyValueToPaymentPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :payment_plans, :daily_value, :float
  end
end
