class RenameServicesToCategoriesAndMakeThemEnum < ActiveRecord::Migration[6.1]
  Ad = Class.new(ActiveRecord::Base)

  CATEGORIES = {
    "Smještaj" => 0,
    "Prijevoz" => 1,
    "Usluga popravka" => 2,
    "Medicinska pomoć" => 3,
    "Ostalo" => 4
  }

  def up
    add_column :ads, :category, :integer, null: false, default: 0
    Ad.all.each do |ad|
      ad.update!(category: CATEGORIES.fetch(ad.service))
    end
    remove_column :ads, :service
  end

  def down
    add_column :ads, :service, :string
    Ad.all.each do |ad|
      ad.update!(service: CATEGORIES.invert.fetch(ad.category, "Smještaj"))
    end
    remove_column :ads, :category
  end
end
