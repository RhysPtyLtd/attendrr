class AddActiveToRanks < ActiveRecord::Migration[5.0]
  def change
    add_column :ranks, :active, :boolean
  end
end
