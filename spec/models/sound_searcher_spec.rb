# frozen_string_literal: true

require "rails_helper"

RSpec.describe SoundSearcher, type: :model do
  let(:searcher) { described_class.new(keyword: keyword) }

  describe ".execute!" do
    let(:keyword) { "荒野を歩け" }

    before "#execute! が呼び出されていることのみを検証するためにスタブする" do
      allow(described_class).to receive(:new).and_return(searcher)
      allow(searcher).to receive(:execute!).and_return(true)
    end

    it "#execute!が呼ばれる" do
      described_class.execute!(keyword: "遥か彼方")
      expect(searcher).to have_received(:execute!)
    end
  end

  describe "#execute!" do
    context "同じ keyword を持つ searches レコードがある場合" do
      context "同じ keyword を持つ searches レコードが作成されてから1日経過していない場合" do
        let(:keyword) { "荒野を歩け" }
        subject(:results) { searcher.execute! }

        before do
          travel_to(Time.current.ago(23.hour)) { FactoryBot.create(:sound) }
        end

        it "searches レコードは作成されない" do
          expect { results }.to_not change { Search.count }
          expect { results }.to_not change { Search.last.created_at }
        end

        it "既存の searches レコードに紐づいた sounds を返す" do
          expect(results.count).to eq 1
          expect(results.first.isrc).to eq "JPU901700684"
          expect(results.first.title).to eq "荒野を歩け"
        end
      end

      context "同じ keyword を持つ searches レコードが作成されてから1日経過している場合" do
        let(:keyword) { "荒野を歩け" }
        let!(:search) { create :search, created_at: Time.current.ago(1.day).to_s }
        subject(:results) { searcher.execute! }

        before do
          # NOTE: 新しいレコードかどうかを検証できるように、isrcなどを factory とは違うものにしている
          new_sounds = [{ isrc: "JPUUUUUU", title: "荒野を歩け(cover)", artist: "cover_artist" }]
          # NOTE: 外部APIにリクエストを飛ばさないようにスタブしている
          allow(searcher).to receive(:fetch_results).and_return(new_sounds)
        end

        it "既存の searches レコードを削除して、新しい searches レコードを作成する" do
          results
          expect(Search.last.created_at).to_not eq search.created_at
          expect { results }.to_not change { Search.count }
        end

        it "新しい search レコードに紐づいた sounds レコードを返す" do
          expect(results.first.isrc).to eq "JPUUUUUU"
          expect(results.first.title).to eq "荒野を歩け(cover)"
          expect(results.first.artist).to eq "cover_artist"
        end
      end
    end

    context "同じ keyword を持つ Search レコードがない場合" do
      let(:keyword) { "遥か彼方" }
      let!(:search) { create :search, keyword: "荒野を歩け" }
      subject(:results) { searcher.execute! }

      before do
        # NOTE: 新しいレコードかどうかを検証できるように、isrcなどを factory とは違うものにしている
        new_sounds = [{ isrc: "JPKS00300301", title: "遥か彼方", artist: "ASIAN KUNG-FU GENERATION" }]
        # NOTE: 外部APIにリクエストを飛ばさないようにスタブしている
        allow(searcher).to receive(:fetch_results).and_return(new_sounds)
      end

      it "search レコードを作成し、それに紐づいた sounds レコードを返す" do
        expect{ results }.to change { Search.count }.from(1).to(2)
        expect(results.first.isrc).to eq "JPKS00300301"
        expect(results.first.title).to eq "遥か彼方"
        expect(results.first.artist).to eq "ASIAN KUNG-FU GENERATION"
      end
    end
  end
end
