class AddStripeCustomerIdToClubs < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :stripe_customer_id, :string
  end
end
