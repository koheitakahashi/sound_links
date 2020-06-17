# frozen_string_literal: true

require "spec_helper"
require "rails_helper"
require "webmock/rspec"
require "support/webmock_spotify_api_helper"

describe "SpotifyRepositoryのmodelテスト", type: :model do
  include WebmockSpotifyApiHelper
  describe "APIレスポンス(mock)を取得する" do
    before do
      mock_spotify_search_results
    end

    it "#search" do
      spotify = SpotifyRepository.new
      actual = spotify.search("リライト")
      expected = [
        {
          spotify_title: "リライト",
          spotify_artists: "ASIAN KUNG-FU GENERATION",
          spotify_url: "https://open.spotify.com/track/3h5e4tpgR9q0cjQXzo8FMD?si=WN7JPlJ5SuSQhrhh9Z-8Yw"
        }
      ]

      expect(expected).to eq actual
    end
  end
end
