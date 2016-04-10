class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.string :city
      t.string :state
      t.string :country
      t.string :name
      t.integer :unique_id
      t.string :directions
      t.float :lat
      t.float :lon

      t.timestamps null: false
    end
    add_index :trails, :unique_id, unique: true
  end
end
