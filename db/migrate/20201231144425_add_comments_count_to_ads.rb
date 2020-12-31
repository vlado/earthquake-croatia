class AddCommentsCountToAds < ActiveRecord::Migration[6.1]
  def change
    add_column :ads, :comments_count, :integer
  end
end
