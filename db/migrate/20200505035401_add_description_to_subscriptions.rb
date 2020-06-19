class AddDescriptionToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :description, :string
  end
end
