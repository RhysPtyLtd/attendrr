class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.boolean :active, default: true
      t.references :club, foreign_key: true

      t.timestamps
    end
  end
end
