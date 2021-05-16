# frozen_string_literal: true

require "rails_helper"

RSpec.describe "楽曲検索機能", type: :system do
  context "検索結果がある場合" do
    before do
      mock_search_results_without_page
      visit root_path
      find(:test, "search-form").set("リライト")
      find(:test, "search-submit-button").click
    end

    it "検索した楽曲のSpotify・Apple Music・KKBOXのURLを表示できる" do
      expect(all(:test, "title")[0].text).to have_content "リライト"
      expect(all(:test, "artist")[0].text).to have_content "ASIAN KUNG-FU GENERATION"
      expect(all(:test, "spotify-url")[0][:href]).to eq "https://open.spotify.com/track/3h5e4tpgR9q0cjQXzo8FMD?si=WN7JPlJ5SuSQhrhh9Z-8Yw"
      expect(all(:test, "apple-music-url")[0][:href]).to eq "https://music.apple.com/jp/album/%E3%83%AA%E3%83%A9%E3%82%A4%E3%83%88/570003767?i=570003920"
      expect(all(:test, "kkbox-url")[0][:href]).to eq "https://www.kkbox.com/jp/ja/song/FcqGD-90I.n6HlVI7lVI70P4-index.html"
    end
  end

  context "検索結果がない場合" do
    before do
      mock_search_when_no_results

      visit root_path
      find(:test, "search-form").set("検索結果なし")
      find(:test, "search-submit-button").click
    end

    it "検索結果がない旨がメッセージで表示される" do
      expect(all(:test, "no-result-message")[0]).to have_content "検索結果がありませんでした"
    end
  end


  describe "ページネーション機能" do
    before do
      FactoryBot.create(:search, keyword: "リライト")
      FactoryBot.create_list(:sound, 10, title: "リライト", search: Search.last)
      FactoryBot.create_list(:sound, 10, title: "リライト(2016)", search: Search.last)
      FactoryBot.create_list(:sound, 10, title: "荒野を歩け", search: Search.last)
    end

    context "1ページ目を表示している場合" do
      before do
        visit root_path
        find(:test, "search-form").set("リライト")
        find(:test, "search-submit-button").click
      end

      context "前のページのボタンを押した場合" do
        it "前のページのボタンを押しても検索結果の表示は変化しない" do
          expect(all(:test, "title")[0].text).to have_content "リライト"
          expect(all(:test, "pagination-current-page-number")[0]).to have_content "1ページ目"

          find(:test, "pagination-previous-button").click

          expect(all(:test, "title")[0].text).to have_content "リライト"
          expect(all(:test, "pagination-current-page-number")[0]).to have_content "1ページ目"
        end
      end

      context "次のページのボタンを押した場合" do
        it "次のページのボタンを押すと2ページ目の結果が表示される" do
          expect(all(:test, "title")[0].text).to have_content "リライト"
          expect(all(:test, "pagination-current-page-number")[0]).to have_content "1ページ目"

          find(:test, "pagination-next-button").click

          expect(all(:test, "title")[0].text).to have_content "リライト(2016)"
          expect(all(:test, "pagination-current-page-number")[0]).to have_content "2ページ目"
        end
      end
    end

    context "2ページ目を表示している場合" do
      before do
        visit root_path
        find(:test, "search-form").set("リライト")
        find(:test, "search-submit-button").click

        find(:test, "pagination-next-button").click
      end

      it "検索結果が表示される" do
        expect(all(:test, "title")[0].text).to have_content "リライト(2016)"
        expect(all(:test, "pagination-current-page-number")[0]).to have_content "2ページ目"
      end

      context "前のページのボタンを押した場合" do
        it "1ページ目の検索結果が表示される" do
          find(:test, "pagination-previous-button").click

          expect(all(:test, "title")[0].text).to have_content "リライト"
          expect(all(:test, "pagination-current-page-number")[0]).to have_content "1ページ目"
        end
      end

      context "次のページのボタンを押した場合" do
        it "3ページ目の結果が表示される" do
          find(:test, "pagination-next-button").click

          expect(all(:test, "title")[0].text).to have_content "荒野を歩け"
          expect(all(:test, "pagination-current-page-number")[0]).to have_content "3ページ目"
        end
      end
    end

    context "トップページを経由せずに、直接2ページ目のURLにアクセスした場合" do
      before do
        visit "/search?keyword=リライト&page=2"
      end

      it "2ページ目の検索結果が表示される" do
        expect(all(:test, "title")[0].text).to have_content "リライト"
        expect(all(:test, "pagination-current-page-number")[0]).to have_content "2ページ目"
      end
    end
  end

  describe "URLコピー機能" do
    it "「この曲をシェア」ボタンでSpotify・Apple Music・KKBOXのURLをクリップボードにコピーできる" do
      skip "navigator.clipboard.writeText ではテスト環境でクリップボードにアクセスできず、テストが通らないため、skip する"

      visit root_path
      find(:test, "search-form").set("リライト")
      find(:test, "search-submit-button").click

      all(:test, "url-copy-button")

      find(:test, "search-form").send_keys %i(shift insert)
      actual = find(:test, "search-form").value

      expected =<<~EOS
        リライト(ASIAN KUNG-FU GENERATION)
        Spotify
        https://open.spotify.com/track/3h5e4tpgR9q0cjQXzo8FMD?si=WN7JPlJ5SuSQhrhh9Z-8Yw
        Apple Music
        https://music.apple.com/jp/album/%E3%83%AA%E3%83%A9%E3%82%A4%E3%83%88/570003767?i=570003920
        KKBOX
        https://www.kkbox.com/jp/ja/song/FcqGD-90I.n6HlVI7lVI70P4-index.html
      EOS

      expect(expected).to eq actual
    end
  end
end
