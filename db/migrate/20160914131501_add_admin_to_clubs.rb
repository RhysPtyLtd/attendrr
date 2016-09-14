class AddAdminToClubs < ActiveRecord::Migration[5.0]
  def change
    add_column :clubs, :admin, :boolean, default: false
  end
end
