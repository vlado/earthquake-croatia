class AddTypeToAds < ActiveRecord::Migration[6.1]
  def change
    add_column :ads, :type, :string, null: false, default: "ponuda"
  end
end
