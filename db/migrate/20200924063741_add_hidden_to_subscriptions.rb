class AddHiddenToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :hidden, :boolean, :default => false
  end
end
