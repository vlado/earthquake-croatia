class RenameKindToServiceOnAds < ActiveRecord::Migration[6.1]
  Ad = Class.new(ActiveRecord::Base)

  def up
    add_column :ads, :service, :string
    Ad.find_each do |ad|
      ad.update_column(:service, ad.kind)
    end
    change_column_null :ads, :service, false
    remove_column :ads, :kind
    add_column :ads, :kind, :integer, default: "0", null: false
    Ad.update_all(kind: 0)
  end

  def down
    remove_column :ads, :kind
    add_column :ads, :kind, :string, default: nil, null: true
    change_column_null :ads, :kind, true
    Ad.find_each do |ad|
      ad.update_column(:kind, ad.service)
    end
    remove_column :ads, :service
  end
end
