# frozen_string_literal: true

require "rails_helper"

module ExternalService
  RSpec.describe AppleMusic, type: :model do
    let(:apple_music) { described_class.new }

    describe "#search" do
      context "引数に1単語が与えられた場合" do
        before do
          mock_apple_music_search_results
        end

        subject(:result) { apple_music.search("リライト").first }

        it { expect(result[:isrc]).to eq "JPKS00400641" }
        it { expect(result[:thumbnail]).to eq "https://is5-ssl.mzstatic.com/image/thumb/Music/v4/33/a3/42/33a342ac-ae02-91c4-4816-28c181b5284b/jacket_KSCL01917B01A_600over.jpg/300x300bb.jpeg" }
        it { expect(result[:title]).to eq "リライト" }
        it { expect(result[:artist]).to eq "ASIAN KUNG-FU GENERATION" }
        it { expect(result[:apple_music_url]).to eq "https://music.apple.com/jp/album/%E3%83%AA%E3%83%A9%E3%82%A4%E3%83%88/570003767?i=570003920" }
      end
    end

    context "引数に空文字が与えられた場合" do
      it { expect(apple_music.search("")).to eq [] }
    end
  end
end
