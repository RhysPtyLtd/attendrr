class AddNewColumnsToClubs < ActiveRecord::Migration[5.0]
  def change
  	add_column :clubs, :address_line_1, :string
  	add_column :clubs, :address_line_2, :string
  	add_column :clubs, :city, :string
  	add_column :clubs, :state, :string
  	add_column :clubs, :postcode, :int
  	add_column :clubs, :country, :string
  	add_column :clubs, :phone1, :string
  	add_column :clubs, :phone2, :string
  	add_column :clubs, :owner_first_name, :string
  	add_column :clubs, :owner_last_name, :string
  end
end
