# frozen_string_literal: true

require "spec_helper"
require "rails_helper"
require "webmock/rspec"
require "support/webmock_spotify_helper"

describe "Spotifyのmodelテスト", type: :model do
  include WebmockSpotifyHelper

  describe "#search" do
    before do
      mock_spotify_search_results
      spotify = Spotify.new
      @result = spotify.search("リライト")
    end

    it { expect(@result.first.isrc).to eq "JPKS00400641" }
    it { expect(@result.first.title).to eq "リライト" }
    it { expect(@result.first.artist).to eq "ASIAN KUNG-FU GENERATION"}
    it { expect(@result.first.spotify_url).to eq "https://open.spotify.com/track/3h5e4tpgR9q0cjQXzo8FMD?si=WN7JPlJ5SuSQhrhh9Z-8Yw" }
    it { expect(@result.first.apple_music_url).to be_nil }
    it { expect(@result.first.youtube_url).to be_nil }
    it { expect(@result.first.youtube_license).to be_nil }
  end
end
