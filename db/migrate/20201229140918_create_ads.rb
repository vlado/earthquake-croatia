class CreateAds < ActiveRecord::Migration[6.1]
  def change
    create_table :ads do |t|
      t.string :city
      t.string :zip
      t.string :phone
      t.text :description
      t.string :email
      t.string :kind

      t.timestamps
    end
  end
end
