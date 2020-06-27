require "spec_helper"
require "rails_helper"
require "webmock/rspec"
require "support/webmock_apis_response_helper"

describe "SoundApiRepositoryのmodelテスト", type: :model do
  include WebmockApisResponseHelper

  describe "Spotify・Apple Music・YouTubeのAPIを介した楽曲情報検索機能" do
    before do
      mock_apis_search_results
    end

    it "#search" do
      sound_api = SoundApisRepository.new
      actual = sound_api.search("リライト")
      expected = [
        {
          isrc: "JPKS00400641",
          title: "リライト",
          artist: "ASIAN KUNG-FU GENERATION",
          spotify_url: "https://open.spotify.com/track/3h5e4tpgR9q0cjQXzo8FMD?si=WN7JPlJ5SuSQhrhh9Z-8Yw",
          apple_music_url: "https://music.apple.com/jp/album/%E3%83%AA%E3%83%A9%E3%82%A4%E3%83%88/570003767?i=570003920",
          youtube_url: "https://youtu.be/cr8magEp0Ho",
          youtube_license: true
        },
        {
          isrc: nil,
          title: "ASIAN KUNG-FU GENERATION 『リライト(2016ver.)』",
          artist: "ASIAN KUNG-FU GENERATION Official YouTube Channel",
          spotify_url: nil,
          apple_music_url: nil,
          youtube_url: "https://youtu.be/bOZixNTn_ck",
          youtube_license: true
        },
      ]

      expect(expected).to eq actual
    end
  end
end
