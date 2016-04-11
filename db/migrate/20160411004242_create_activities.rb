class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :unique_id
      t.references :trail, index: true, foreign_key: true
      t.string :activity_type_name
      t.string :url
      t.string :description
      t.decimal :length
      t.integer :rating

      t.timestamps null: false
    end
  end
end
