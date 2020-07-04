# frozen_string_literal: true

require "spec_helper"
require "rails_helper"
require "webmock/rspec"
require "support/webmock_apple_music_helper"

describe "AppelMusicのmodelテスト", type: :model do
  include WebmockAppleMusicHelper

  describe "#search" do
    before do
      mock_apple_music_search_results
      apple_music = AppleMusic.new
      @result = apple_music.search("リライト")
    end

    it { expect(@result.first.isrc).to eq "JPKS00400641" }
    it { expect(@result.first.title).to eq "リライト" }
    it { expect(@result.first.artist).to eq "ASIAN KUNG-FU GENERATION"}
    it { expect(@result.first.spotify_url).to be_nil }
    it { expect(@result.first.apple_music_url).to eq "https://music.apple.com/jp/album/%E3%83%AA%E3%83%A9%E3%82%A4%E3%83%88/570003767?i=570003920" }
    it { expect(@result.first.youtube_url).to be_nil }
    it { expect(@result.first.youtube_license).to be_nil }
  end
end
