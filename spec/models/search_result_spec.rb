# frozen_string_literal: true

require "rails_helper"

describe "SearchResultのモデルテスト", type: :model do
  let(:result_1) {
    SearchResult.new(
      isrc: "JPKS00400641",
      title: "リライト",
      artist: "ASIAN KUNG-FU GENERATION",
      spotify_url: "https://open.spotify.com/track/3h5e4tpgR9q0cjQXzo8FMD?si=WN7JPlJ5SuSQhrhh9Z-8Yw",
      apple_music_url: "https://music.apple.com/jp/album/%E3%83%AA%E3%83%A9%E3%82%A4%E3%83%88/570003767?i=570003920",
      youtube_url: "https://youtu.be/cr8magEp0Ho",
      youtube_license: true
    )
  }

  let(:result_2) {
    SearchResult.new(
      isrc: nil,
      title: "ASIAN KUNG-FU GENERATION 『リライト(2016ver.)』",
      artist: "ASIAN KUNG-FU GENERATION Official YouTube Channel",
      spotify_url: nil,
      apple_music_url: nil,
      youtube_url: "https://youtu.be/bOZixNTn_ck",
      youtube_license: true
    )

  }
  describe "#merge" do
    subject(:result) {result_1.merge(result_2) }

    it { expect(result.isrc).to eq "JPKS00400641" }
    it { expect(result.title).to eq "リライト" }
    it { expect(result.artist).to eq "ASIAN KUNG-FU GENERATION" }
    it { expect(result.spotify_url).to eq "https://open.spotify.com/track/3h5e4tpgR9q0cjQXzo8FMD?si=WN7JPlJ5SuSQhrhh9Z-8Yw" }
    it { expect(result.apple_music_url).to eq "https://music.apple.com/jp/album/%E3%83%AA%E3%83%A9%E3%82%A4%E3%83%88/570003767?i=570003920" }
    it { expect(result.youtube_url).to eq "https://youtu.be/cr8magEp0Ho" }
    it { expect(result.youtube_license).to be true }
  end
end
