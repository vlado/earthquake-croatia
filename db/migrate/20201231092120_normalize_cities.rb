class NormalizeCities < ActiveRecord::Migration[6.1]
  def up
    puts "Normalizing city names..."

    Ad.all.find_each do |ad|
      ad.city = ad.city.squish
      # if it's only one word, make sure it's not ALLCAPS
      ad.city = if ad.city.split(/[^[[:word:]]]+/).size == 1
                  ad.city.titleize
                else
                  ad.city.upcase_first
                end
      # skip validation to prevent NormalizeColumn to kick in
      ad.save!(validate: false)
    end

    Ad.where(city: 'Bijelovar').update_all(city: 'Bjelovar')
    Ad.where(city: 'Dakovo').or(Ad.where(city: 'Djakovo')).update_all(city: 'Đakovo')
    Ad.where(city: 'Fažana Pula').update_all(city: 'Fažana')
    Ad.where(city: 'Ivanić-Grad').update_all(city: 'Ivanić Grad')
    Ad.where(city: 'JANJINA (PELJEŠAC)').update_all(city: 'Janjina (Pelješac)')
    Ad.where(city: 'Kaštela (Lukšić)').update_all(city: 'Kaštel Lukšić')
    Ad.where(city: 'Korivnica').update_all(city: 'Koprivnica')
    Ad.where(city: 'KRAVARSKO-NOVO BRDO').update_all(city: 'Kravarsko - Novo Brdo')
    Ad.where(city: 'MOSTAR').update_all(city: 'Mostar')
    Ad.where(city: 'MURTER').update_all(city: 'Murter')
    Ad.where(city: 'Osjek').update_all(city: 'Osijek')
    Ad.where(city: '---orebić').update_all(city: 'Orebić')
    Ad.where(city: 'Podstrana , Split').or(Ad.where(city: 'Podstrana Split')).update_all(city: 'Podstrana')
    Ad.where(city: 'SPLITSKA OTOK BRAČ').update_all(city: 'Splitska otok Brač')
    Ad.where(city: 'Varazdinu').update_all(city: 'Varaždin')
    Ad.where(city: 'Zaagreb').or(Ad.where(city: 'Grad Zagreb')).update_all(city: 'Zagreb')
    Ad.where(city: 'ZAGREB( SESVETE)').update_all(city: 'Sesvete')
    Ad.where(city: 'Vodice, ČISTA VELIKA').update_all(city: 'Vodice, Čista Velika')
    Ad.where(city: 'Zašrešić').update_all(city: 'Zaprešić')
    Ad.where(city: 'Jesenice(Omiš)').update_all(city: 'Jesenice (Omiš)')

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

  # do nothing, we don't need to fail if going down
  def down; end
end
