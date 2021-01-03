class AddMissingIndexes < ActiveRecord::Migration[6.1]
  def change
    # we use these two for filtering
    add_index :ads, :city
    add_index :ads, :kind
    # we use this one for ordering of ads
    add_index :ads, :created_at
  end
end
