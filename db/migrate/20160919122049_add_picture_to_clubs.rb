class AddPictureToClubs < ActiveRecord::Migration[5.0]
  def change
    add_column :clubs, :picture, :string
  end
end
