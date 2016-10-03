class CreateRanks < ActiveRecord::Migration[5.0]
  def change
    create_table :ranks do |t|
      t.string :name
      t.integer :position
      t.boolean :active, default: true
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end
