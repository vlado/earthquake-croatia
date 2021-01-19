namespace :ads do
  desc 'Merges different spelling of city names into one per city'
  task normalize_city_names: :environment do
    puts "Normalizing city names..."

    Ad.find_each do |ad|
      city = ad.city.squish
      # if it's only one word, make sure it's not ALLCAPS
      city = if city.split(/[^[[:word:]]]+/).size == 1
                city.titleize
              else
                city.upcase_first
              end
      # skip validation to prevent NormalizeCityName to kick in
      ad.update_column(:city, city)
    end

    cities_mapping = YAML.load_file(Rails.root.join('lib/tasks/cities_mapping.yml'))['cities']

    cities_mapping.each do |misspelled_city_name, correct_city_name|
      Ad.where('lower(city) = ?', misspelled_city_name).update_all(city: correct_city_name)
    end

    puts "City names normalized!"
  end

  desc "Send reminder emails to remind up to 300 oldest emails to update it."
  task send_reminders: :environment do
    count = AdReminder.new.remind_oldest(300).size

    puts "Oldest #{count} emails reminded."
  end
end
