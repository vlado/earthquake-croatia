class AddConsentToAds < ActiveRecord::Migration[6.1]
  def change
    add_column :ads, :consent, :boolean
  end
end
