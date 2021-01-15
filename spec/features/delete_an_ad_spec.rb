# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Ad deleting", type: :system do
  let(:topmost_ad) { Ad.ordered.for_kind("supply").first or create(:ad, kind: :supply) }

  def delete_link_from_last_email
    email_body = ActionMailer::Base.deliveries.last.body.to_s
    delete_links = email_body.scan(%r{http://.+/delete/new\?t=[0-9a-f]+})
    raise "Expected exactly one delete link in email but found #{delete_links.size}" unless delete_links.size == 1

    delete_links.first
  end

  def open_topmost_ad_delete_form
    within(first(:css, ".ad-card")) do
      find(".dropdown-trigger").click
      click_on("Obriši oglas")
    end
  end

  def submit_request_to_delete(with:)
    fill_in "Email", with: with
    click_on "Pošalji"
  end

  before do
    # Ensure that topmost ad is editable
    topmost_ad.update!(email: "tester@example.com", created_at: Time.zone.now)

    visit "/"
    expect(page).to have_content topmost_ad.description
    open_topmost_ad_delete_form
    submit_request_to_delete with: topmost_ad.email
    visit delete_link_from_last_email
  end

  it "removes the ad from the list" do
    click_on "Obriši"

    expect(page).to have_content "Oglas obrisan"
    expect(page).not_to have_content topmost_ad.description
  end

  it "allows specifying reason and comment for deletion" do
    old_reason_count = Reason.count

    select "Kontaktirali su nas preko ove stranice", from: "Razlog za brisanje"
    fill_in "Dodatno pojašnjenje", with: "Proslo je dobro"

    click_on "Obriši"

    expect(page).not_to have_content topmost_ad.description
    expect(Reason.count).to eq old_reason_count + 1
    reason = Reason.last
    expect(reason.code).to eq "gave_help_here"
    expect(reason.comment).to eq "Proslo je dobro"
  end
end
