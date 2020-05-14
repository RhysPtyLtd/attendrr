class AddStudentLimitToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :student_limit, :integer
  end
end
