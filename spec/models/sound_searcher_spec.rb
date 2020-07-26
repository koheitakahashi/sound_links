# frozen_string_literal: true

require "rails_helper"

RSpec.describe SoundSearcher, type: :model do
  let(:sound_api) { described_class.new }

  describe "#search" do
    before do
      mock_search_results
    end

    subject(:results) { sound_api.search("リライト") }

    it { expect(results.count).to eq 2 }

    it { expect(results.first.isrc).to eq "JPKS00400641" }
    it { expect(results.first.title).to eq "リライト" }
    it { expect(results.first.artist).to eq "ASIAN KUNG-FU GENERATION" }
    it { expect(results.first.spotify_url).to eq "https://open.spotify.com/track/3h5e4tpgR9q0cjQXzo8FMD?si=WN7JPlJ5SuSQhrhh9Z-8Yw" }
    it { expect(results.first.apple_music_url).to eq "https://music.apple.com/jp/album/%E3%83%AA%E3%83%A9%E3%82%A4%E3%83%88/570003767?i=570003920" }
    it { expect(results.first.youtube_url).to eq "https://youtu.be/cr8magEp0Ho" }
    it { expect(results.first.youtube_license).to be true }
  end
end
