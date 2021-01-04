class ConnectAdWithCity < ActiveRecord::Migration[6.1]
  def change
    ActiveRecord::Base.transaction do
      Rake::Task['db:seed_locations'].invoke
      rename_column :ads, :city, :city_zdel
      add_reference :ads, :city, foreign_key: true, index: true
      Ad.find_each(batch_size: 100) do |ad|
        ad.update!(city_id: City.find_by_name(ad.city_zdel).id )
      end
      remove_column :ads, :city_zdel
      change_column_null :ads, :city_id, false
    end
  end
end
