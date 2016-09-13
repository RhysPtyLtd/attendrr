class AddIndexToClubsEmail < ActiveRecord::Migration[5.0]
  def change
  	add_index :clubs, :email, unique: true
  end
end
