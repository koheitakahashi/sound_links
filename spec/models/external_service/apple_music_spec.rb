# frozen_string_literal: true

require "rails_helper"

module ExternalService
  RSpec.describe AppleMusic, type: :model do
    let(:apple_music) { described_class.new }

    describe "#search" do
      before do
        mock_apple_music_search_results
      end

      subject(:result) { apple_music.search("リライト").first }

      it { expect(result[:isrc]).to eq "JPKS00400641" }
      it { expect(result[:title]).to eq "リライト" }
      it { expect(result[:artist]).to eq "ASIAN KUNG-FU GENERATION" }
      it { expect(result[:apple_music_url]).to eq "https://music.apple.com/jp/album/%E3%83%AA%E3%83%A9%E3%82%A4%E3%83%88/570003767?i=570003920" }
    end
  end
end
