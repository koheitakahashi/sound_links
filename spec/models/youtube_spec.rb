# frozen_string_literal: true

require "rails_helper"

describe "Youtubeのmodelテスト", type: :model do
  let(:youtube) { Youtube.new }

  describe "#search" do
    before do
      mock_youtube_search_results
    end

    subject(:results) { youtube.search("リライト") }

    it { expect(results.count).to eq 2 }

    it { expect(results.first.title).to eq "ASIAN KUNG-FU GENERATION　『リライト』" }
    it { expect(results.first.artist).to eq "ASIAN KUNG-FU GENERATION Official YouTube Channel" }
    it { expect(results.first.youtube_url).to eq "https://youtu.be/cr8magEp0Ho" }
    it { expect(results.first.youtube_license).to be true }

    it { expect(results.second.title).to eq "ASIAN KUNG-FU GENERATION 『リライト(2016ver.)』" }
    it { expect(results.second.artist).to eq "ASIAN KUNG-FU GENERATION Official YouTube Channel" }
    it { expect(results.second.youtube_url).to eq "https://youtu.be/bOZixNTn_ck" }
    it { expect(results.second.youtube_license).to be true }
  end
end
