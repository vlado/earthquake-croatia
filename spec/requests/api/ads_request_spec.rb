require 'rails_helper'

RSpec.describe "Api::Ads", type: :request do
  def json_body
    JSON.parse(response.body)
  end

  it "returns active ads in json format" do
    ad1 = create(:ad, kind: :supply)
    ad2 = create(:ad, kind: :demand)
    create(:ad, deleted_at: Time.zone.now)

    get "/api/ads.json"

    body = json_body
    expect(body.size).to eq 2
    expect(body.pluck("id")).to match_array [ad1.id, ad2.id]
  end

  it "filters ads by kind if kind param is provided" do
    ad = create(:ad, kind: :demand)
    create(:ad, kind: :supply)

    get "/api/ads.json?kind=demand"

    body = json_body
    expect(body.size).to eq 1
    expect(body.pluck("id")).to match_array [ad.id]
  end

  it "filters ads by category if category param is provided" do
    ad = create(:ad, kind: :supply, category: "accomodation")
    create(:ad, kind: :demand, category: "transport")

    get "/api/ads.json?category=accomodation"

    body = json_body
    expect(body.size).to eq 1
    expect(body.pluck("id")).to match_array [ad.id]
  end

  it "ads pagination headers" do
    stub_const("Api::AdsController::MIN_PER_PAGE", 2)
    6.times { create(:ad) }

    get "/api/ads.json?page=2"

    expect(response.headers["Link"]).to eq '<http://www.example.com/api/ads.json?page=1>; rel="first", <http://www.example.com/api/ads.json?page=1>; rel="prev", <http://www.example.com/api/ads.json?page=3>; rel="last", <http://www.example.com/api/ads.json?page=3>; rel="next"'
    expect(response.headers["Per-Page"]).to eq "2"
    expect(response.headers["Total"]).to eq "6"
  end
end
