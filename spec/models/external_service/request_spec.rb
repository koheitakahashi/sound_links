# frozen_string_literal: true

require "rails_helper"

module ExternalService
  RSpec.describe Request, type: :model do
    let(:request) { described_class.new }

    describe "#get" do
      before do
        mock_get_request
      end

      subject(:response) { request.get(
        url: SoundLinksConstants::SPOTIFY_SEARCH_URL,
        headers: { Authorization: "Bearer NEW_ACCESS_TOKEN" },
        params: { q: "リライト", type: "track", market: "JP", limit: 5 })}

      context "url と headers と params を渡した場合"  do
        it { expect(response.body["tracks"]["items"].first["external_ids"]["isrc"]).to eq "JPKS00400641" }
        it { expect(response.body["tracks"]["items"].first["name"]).to eq "リライト" }
      end
    end

    describe "#post" do
      before do
        mock_post_request
      end

      subject(:response) { request.post(
        url: SoundLinksConstants::SPOTIFY_AUTH_URL,
        body: "grant_type=client_credentials",
        headers: { Authorization: "Basic authorization_key" })}

      context "url と headers と params を渡した場合"  do
        it { expect(response.body["access_token"]).to eq "NEW_ACCESS_TOKEN" }
      end
    end
  end
end
