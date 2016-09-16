class AddResetToClubs < ActiveRecord::Migration[5.0]
  def change
    add_column :clubs, :reset_digest, :string
    add_column :clubs, :reset_sent_at, :datetime
  end
end
