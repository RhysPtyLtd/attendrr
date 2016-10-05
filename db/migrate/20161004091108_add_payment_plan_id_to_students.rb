class AddPaymentPlanIdToStudents < ActiveRecord::Migration[5.0]
  def change
  	add_column :students, :payment_plan_id, :integer
  end
end
