class AddColumnsToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :name, :string
    add_column :subscriptions, :cost, :decimal
  end
end
