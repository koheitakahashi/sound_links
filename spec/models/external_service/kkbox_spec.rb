# frozen_string_literal: true

require "rails_helper"

module ExternalService
  RSpec.describe Kkbox, type: :model do
    let(:kkbox) { described_class.new }

    describe "#search" do
      context "引数に1単語が与えられた場合" do
        before do
          mock_kkbox_search_results
        end

        subject(:result) { kkbox.search("リライト").first }

        it { expect(result[:isrc]).to eq "JPKS00400641" }
        it { expect(result[:thumbnail_url]).to eq "https://i.kfs.io/album/global/1825860,5v1/fit/160x160.jpg" }
        it { expect(result[:title]).to eq "リライト" }
        it { expect(result[:artist]).to eq "ASIAN KUNG-FU GENERATION" }
        it { expect(result[:kkbox_url]).to eq "https://www.kkbox.com/jp/ja/song/FcqGD-90I.n6HlVI7lVI70P4-index.html" }
      end

      context "引数に空文字が与えられた場合" do
        it { expect(kkbox.search("")).to eq [] }
      end

      context "外部APIからエラーレスポンスが返ってきた場合" do
        before do
          mock_kkbox_authentication_error_response
        end

        it " ExternalService::Errorが raise される" do
          expect { kkbox.search("bad_params") }.to raise_error { |error|
            expect(error.message).to eq "There was an error connecting with the KKBOX API. HTTP Status Code: 401, Error message: Invalid Authentication" }
        end
      end
    end
  end
end
