class RemoveActiveFromRanks < ActiveRecord::Migration[5.0]
  def change
    remove_column :ranks, :active, :boolean
  end
end
