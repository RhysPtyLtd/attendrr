class AddActivationToClubs < ActiveRecord::Migration[5.0]
  def change
    add_column :clubs, :activation_digest, :string
    add_column :clubs, :activated, :boolean, default: false
    add_column :clubs, :activated_at, :datetime
  end
end
