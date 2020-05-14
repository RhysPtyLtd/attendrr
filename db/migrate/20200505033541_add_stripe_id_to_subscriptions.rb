class AddStripeIdToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :stripe_id, :string
  end
end
