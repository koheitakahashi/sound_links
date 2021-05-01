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
        it { expect(result[:thumbnail_url]).to eq "https://i.scdn.co/image/ab67616d00001e02fa355dc948984a72010ff83e" }
        it { expect(result[:title]).to eq "リライト" }
        it { expect(result[:artist]).to eq "ASIAN KUNG-FU GENERATION" }
        it { expect(result[:spotify_url]).to eq "https://open.spotify.com/track/3h5e4tpgR9q0cjQXzo8FMD?si=WN7JPlJ5SuSQhrhh9Z-8Yw" }
      end

      context "引数に空文字が与えられた場合" do
        it { expect(spotify.search("")).to eq [] }
      end

      context "外部APIからエラーレスポンスが返ってきた場合" do
        before do
          mock_spotify_error_response
        end

        it " ExternalService::Errorが raise される" do
          expect { spotify.search("bad_params") }.to raise_error { |error|
            expect(error.message).to eq "There was an error connecting with the Spotify API. HTTP Status Code: 401, Response error message: No token provided" }
        end
      end
    end
  end
end
