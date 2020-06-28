# frozen_string_literal: true

require "spec_helper"
require "rails_helper"
require "webmock/rspec"
require "support/webmock_spotify_api_helper"

describe "Spotifyのmodelテスト", type: :model do
  include WebmockSpotifyApiHelper
  describe "APIレスポンス(mock)を取得する" do
    before do
      mock_spotify_search_results
    end

    it "#search" do
      spotify = Spotify.new
      actual = spotify.search("リライト")
      expected = [
        {
          isrc: "JPKS00400641",
          title: "リライト",
          artist: "ASIAN KUNG-FU GENERATION",
          spotify_url: "https://open.spotify.com/track/3h5e4tpgR9q0cjQXzo8FMD?si=WN7JPlJ5SuSQhrhh9Z-8Yw"
        }
      ]

      expect(expected).to eq actual
    end
  end
end
