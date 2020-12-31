namespace :ads do
  desc 'Merges different spelling of city names into one per city'
  task normalize_city_names: :environment do
    puts "Normalizing city names..."

    Ad.all.find_each do |ad|
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
      Ad.where(city: misspelled_city_name).update_all(city: correct_city_name)
    end

    correctly_spelled_cities = %w[
      Andrijaševci
      Baška\ voda
      Biograd\ na\ moru
      Brač
      Čakovec Čiovo
      Dugo\ Selo
      Fažana Gospić
      Ivanić\ Grad
      Kaštel\ Lukšić
      Kloštar\ Ivanić
      Kopačevo
      Križevci
      Nova\ Gradiška
      Omiš Orebić
      Otok\ Vir
      Pakoštane
      Plitvička\ Jezera
      Ploče Poreč Primošten
      Stara\ Gradiška
      Šibenik
      Tučepi
      Varaždin
      Veli\ Lošinj
      Velika\ Gorica
      Zaprešić Županja
    ]

    correctly_spelled_cities.each do |city|
      Ad.where("unaccent(city) ILIKE unaccent(?)", city).update_all(city: city)
    end

    puts "City names normalized!"
  end
end
