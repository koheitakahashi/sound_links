# frozen_string_literal: true

require "rails_helper"

module ExternalService
  RSpec.describe Spotify, type: :model do
    let(:spotify) { described_class.new }

    describe "#search" do
      context "引数に1単語が与えられた場合" do
        before do
          mock_spotify_search_results
        end

        subject(:result) { spotify.search("リライト").first }

        it { expect(result[:isrc]).to eq "JPKS00400641" }
        it { expect(result[:title]).to eq "リライト" }
        it { expect(result[:artist]).to eq "ASIAN KUNG-FU GENERATION" }
        it { expect(result[:spotify_url]).to eq "https://open.spotify.com/track/3h5e4tpgR9q0cjQXzo8FMD?si=WN7JPlJ5SuSQhrhh9Z-8Yw" }
      end

      context "引数に空文字が与えられた場合" do
        it { expect(spotify.search("")).to eq [] }
      end
    end
  end
end
