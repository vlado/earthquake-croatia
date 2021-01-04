class AddTokenToAds < ActiveRecord::Migration[6.1]
  def change
    add_column :ads, :token, :string
    add_index :ads, :token, unique: true
  end
end
