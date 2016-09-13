class AddPasswordDigestToClubs < ActiveRecord::Migration[5.0]
  def change
    add_column :clubs, :password_digest, :string
  end
end
