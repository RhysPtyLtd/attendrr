class AddDefaultValueToActiveRank < ActiveRecord::Migration[5.0]
  def change
  	change_column :ranks, :active, :boolean, default: true
  end
end
