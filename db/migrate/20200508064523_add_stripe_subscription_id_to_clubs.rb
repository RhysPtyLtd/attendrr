class AddStripeSubscriptionIdToClubs < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :stripe_subscription_id, :string
  end
end
