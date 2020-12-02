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
        it { expect(result[:title]).to eq "リライト" }
        it { expect(result[:artist]).to eq "ASIAN KUNG-FU GENERATION" }
        it { expect(result[:kkbox_url]).to eq "https://www.kkbox.com/jp/ja/song/FcqGD-90I.n6HlVI7lVI70P4-index.html" }
      end

      context "引数に空文字が与えられた場合" do
        it { expect(kkbox.search("") ).to eq [] }
      end
    end
  end
end
