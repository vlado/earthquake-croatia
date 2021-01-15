# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Ad posting", type: :system do
  def fill_ad_details
    select "Građevinski materijal", from: "Usluga"
    select2 "Petrinja", from: "Grad", search: true
    fill_in "Adresa", with: "Glavni trg 1"
    fill_in "Kontakt Telefon", with: "044555555"
    fill_in "Email", with: "tester@potres-petrinja.hr"
    fill_in "Opis", with: "Crijepovi i cigle"
  end

  def verify_ad_is_visible
    expect(page).to have_content("Crijepovi i cigle")
    expect(page).to have_content("044555555")
  end

  before do
    create(:city, name: "Petrinja")
  end

  def create_ad(type:)
    visit "/"
    click_on "Dodaj oglas"

    select type, from: "Tip oglasa"
    fill_ad_details
    check "Pristajem"

    click_on "Spremi"
  end

  it "supports posting an ad offering help" do
    create_ad(type: "Nudim pomoć")

    expect(page).to have_content("Oglas uspješno dodan!")
    verify_ad_is_visible
  end

  it "supports posting an ad asking for help" do
    create_ad(type: "Tražim pomoć")

    expect(page).to have_content("Oglas uspješno dodan!")
    verify_ad_is_visible
  end
end
