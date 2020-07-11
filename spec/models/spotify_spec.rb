# frozen_string_literal: true

require "rails_helper"

describe "Spotifyのmodelテスト", type: :model do
  let(:spotify) { Spotify.new }

  describe "#search" do
    before do
      mock_spotify_search_results
    end

    subject(:result) { spotify.search("リライト").first }

    it { expect(result.isrc).to eq "JPKS00400641" }
    it { expect(result.title).to eq "リライト" }
    it { expect(result.artist).to eq "ASIAN KUNG-FU GENERATION" }
    it { expect(result.spotify_url).to eq "https://open.spotify.com/track/3h5e4tpgR9q0cjQXzo8FMD?si=WN7JPlJ5SuSQhrhh9Z-8Yw" }
    it { expect(result.apple_music_url).to be_nil }
    it { expect(result.youtube_url).to be_nil }
    it { expect(result.youtube_license).to be_nil }
  end
end
