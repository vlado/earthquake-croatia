class AddAddressToAd < ActiveRecord::Migration[6.1]
  def change
    add_column :ads, :address, :string
  end
end
