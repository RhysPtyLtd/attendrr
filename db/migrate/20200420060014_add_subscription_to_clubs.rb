class AddSubscriptionToClubs < ActiveRecord::Migration[5.2]
  def change
    add_reference :clubs, :subscription, foreign_key: true
  end
end
