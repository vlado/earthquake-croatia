class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.string :area_name
      t.references :county, foreign_key: true, index: true
      t.string :name
      t.integer :zip_code 
      t.timestamps
    end
  end
end
