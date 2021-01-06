class AddTokenAndDeletedAtToAds < ActiveRecord::Migration[6.1]
  def change
    add_column :ads, :token, :string
    add_index :ads, :token, unique: true
    add_column :ads, :deleted_at, :datetime
    add_index :ads, :deleted_at
  end
end
