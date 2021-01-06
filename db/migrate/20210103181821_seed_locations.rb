class SeedLocations < ActiveRecord::Migration[6.1]
  City = Class.new(ActiveRecord::Base)
  County = Class.new(ActiveRecord::Base)

  def up
    Rake::Task['db:seed_locations'].invoke
  end

  def down
    City.delete_all
    County.delete_all
  end
end
