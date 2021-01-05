class ConnectAdWithCity < ActiveRecord::Migration[6.1]
  Ad = Class.new(ActiveRecord::Base)
  City = Class.new(ActiveRecord::Base)
  County = Class.new(ActiveRecord::Base)

  FOREIGN_CITIES = {
    "Adlešiči, Slovenija" => nil,
    "Bihać BiH" => "Bosna i Hercegovina",
    "Budva" => "Crna Gora",
    "Kranj" => "Slovenija",
    "Međugorje" => "Bosna i Hercegovina",
    "Mostar" => "Bosna i Hercegovina",
    "Neum" => "Bosna i Hercegovina",
    "Radenci" => "Slovenija",
    "Skopje" => "Makedonija",
    "Tomislavgrad" => "Bosna i Hercegovina",
    "Tuzla" => "Bosna i Hercegovina",
    "Waterford" => "Irska",
  }.freeze

  CITIES_MAPPING = {
    "Bale" => "Bale - Valle",
    "Banski Grabovac" => "Grabovac Banski",
    "Baška voda" => "Baška Voda",
    "Biljane Gornje" => "Gornje Biljane",
    "Brna" => "Korčula",
    "Brtonigla" => "Brtonigla - Verteneglio",
    "Fažana" => "Fažana - Fasana",
    "Funtana" => "Poreč",
    "Gornja Hlapa" => "Hlapa",
    "Gračac, Srb" => "Gračac",
    "Gračišće, Istra" => "Gračišće",
    "Herrenberg" => "Osijek",
    "Karin Gornji" => "Gornji Karin",
    "Kastela" => "Kaštel Novi",
    "Klinca sela" => "Klinča Sela",
    "Konavle" => "Gruda",
    "Kravarsko - Novo Brdo" => "Novo Brdo",
    "Moscenica" => "Moščenica",
    "Neorić-Sutina" => "Neorić",
    "Okolica Sinja" => "Sinj",
    "Oprtalj" => "Oprtalj - Portole",
    "Otok Hvar" => "Hvar",
    "Otok Krk" => "Krk",
    "Otok Ugljan" => "Ugljan",
    "Peroj" => "Peroj - Peroi",
    "Podstrana" => "Stobreč",
    "Pula" => "Pula - Pola",
    "Rovinj" => "Rovinj - Rovigno",
    "Runovići" => "Runović",
    "Savudrija" => "Savudrija - Salvore",
    "Seget" => "Seget - Seghetto",
    "Selo Jezero Posavsko" => "Jezero Posavsko",
    "St. Toplice" => "Oroslavje",
    "Trosnj" => "Trpanj",
    "Vabriga" => "Vabriga - Abrega",
    "Velika Graduša" => "Velika Gradusa",
    "Vocin" => "Voćin",
    "Vodnjan" => "Vodnjan - Dignano",
    "Vrsar" => "Vrsar - Orsera",
    "Zadarska županija" => "Zadar",
    "Zagrebacka zupanija Varazdinska Krapinsko zagorska" => "Zagreb",
    "Zelina" => "Sveti Ivan Zelina",
    "Zlatar Bistrica" => "Zlatar-Bistrica",
    "Čađavački Lug" => "Čađavički Lug",
    "Čiovo" => "Trogir",
    "Čiovo, Zagreb" => "Trogir",
    "šibenik" => "Šibenik",
  }.freeze

  def up
    create_missing_cities

    rename_column :ads, :city, :city_zdel
    add_reference :ads, :city, foreign_key: true, index: true

    cities = []
    Ad.find_each(batch_size: 100) do |ad|
      if FOREIGN_CITIES.keys.include?(ad.city_zdel)
        import_foreign_ad(ad)
      else
        import_hr_ad(ad)
      end
    end

    remove_column :ads, :city_zdel
    change_column_null :ads, :city_id, false
  end

  def down

  end

  private

  def create_missing_cities
    # We need Zagreb cause we have lot of entries with just Zagreb
    # and do not know where to place them
    City.create!(
      area_name: "Zagreb",
      county_id: County.find_by!(name: "GRAD ZAGREB"),
      name: "Zagreb",
      zip_code: 10000
    )
    # Let's add "foreign" county and cities
    county = County.create!(name: "Inozemstvo")
    FOREIGN_CITIES.each do |city, country|
      City.create!(name: [city, country].compact.join(", "), county_id: county.id)
    end
  end

  def import_foreign_ad(ad)
    city = City.find_by("name ILIKE ?", "#{ad.city_zdel}%")
    if city
      ad.update!(city_id: city.id )
    else
      raise "Can not found foreign city `#{ad.city_zdel}`"
    end
  end

  def import_hr_ad(ad)
    city_name =CITIES_MAPPING[ad.city_zdel] || ad.city_zdel
    city = City.find_by(name: city_name) || City.find_by(zip_code: ad.zip)
    if city
      ad.update!(city_id: city.id )
    else
      raise "Can not foundi HR city `#{city_name}`"
    end
  end
end
