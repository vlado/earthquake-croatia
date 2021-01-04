class AddIndexToKindOnAds < ActiveRecord::Migration[6.1]
  def change
    add_index :ads, :kind, if_not_exists: true
  end
end
