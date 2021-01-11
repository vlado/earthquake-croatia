# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Ad deleting", type: :system do
  let(:topmost_ad) { Ad.ordered.for_kind("supply").first }

  before do
    # Ensure that topmost ad is editable
    topmost_ad.update!(email: "tester@example.com")
  end

  def delete_link_from_last_email
    email_body = ActionMailer::Base.deliveries.last.body.to_s
    delete_links = email_body.scan(%r{http://.+/delete/new\?t=[0-9a-f]+})
    raise "Expected exactly one delete link in email but found #{delete_links.size}" unless delete_links.size == 1
    delete_links.first
  end

  def open_topmost_ad_delete_form
    within(first(:css, ".ad-card")) do
      expect(page).to have_content topmost_ad.description
      find(".dropdown-trigger").click
      click_on("Obriši oglas")
    end
  end

  it "remove the ad from the list" do
    visit "/"
    open_topmost_ad_delete_form

    fill_in "Email", with: topmost_ad.email
    click_on "Pošalji"

    visit delete_link_from_last_email
    click_on "Obriši"

    expect(page).to have_content "Oglas obrisan"
    expect(page).not_to have_content topmost_ad.description
  end
end
