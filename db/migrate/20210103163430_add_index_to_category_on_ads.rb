class AddIndexToCategoryOnAds < ActiveRecord::Migration[6.1]
  def change
    add_index :ads, :category
  end
end
