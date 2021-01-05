class SeedLocations < ActiveRecord::Migration[6.1]
  def up
    Rake::Task['db:seed_locations'].invoke
  end

  def down
    City.delete_all
    County.delete_all
  end
end
