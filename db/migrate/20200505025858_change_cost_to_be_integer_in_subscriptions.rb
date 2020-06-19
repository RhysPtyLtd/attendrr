class ChangeCostToBeIntegerInSubscriptions < ActiveRecord::Migration[5.2]
  def change
  	change_column :subscriptions, :cost, :integer
  end
end
