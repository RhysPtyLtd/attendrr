class AddRememberDigestToClubs < ActiveRecord::Migration[5.0]
  def change
    add_column :clubs, :remember_digest, :string
  end
end
