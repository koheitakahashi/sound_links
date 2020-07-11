# frozen_string_literal: true

require "rails_helper"

describe "Youtubeのmodelテスト", type: :model do
  describe "#search" do
    before do
      mock_youtube_search_results
      youtube= Youtube.new
      @results = youtube.search("リライト")
    end

    it { expect(@results.first.isrc).to be_nil }
    it { expect(@results.first.title).to eq "ASIAN KUNG-FU GENERATION　『リライト』" }
    it { expect(@results.first.artist).to eq "ASIAN KUNG-FU GENERATION Official YouTube Channel" }
    it { expect(@results.first.spotify_url).to be_nil }
    it { expect(@results.first.apple_music_url).to be_nil }
    it { expect(@results.first.youtube_url).to eq "https://youtu.be/cr8magEp0Ho" }
    it { expect(@results.first.youtube_license).to be true }

    it { expect(@results.count).to eq 2 }
    it { expect(@results.second.title).to eq "ASIAN KUNG-FU GENERATION 『リライト(2016ver.)』" }
  end
end
