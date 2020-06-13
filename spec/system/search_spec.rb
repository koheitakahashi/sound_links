# frozen_string_literal: true

require "rails_helper"
# TODO API helperが多いので、それをまとめるhelperを作成すること
require "support/webmock_spotify_api_helper.rb"
require "support/webmock_youtube_api_helper.rb"

describe "楽曲検索機能", type: :system do
  include WebmockSpotifyApiHelper
  include WebmockYoutubeApiHelper

  context "検索フォームに入力した楽曲をSpotify APIを介して検索" do
    before do
      mock_spotify_search_results
      mock_youtube_search_results
    end

    it "検索結果を表示する" do
      visit root_path
      fill_in "query", with: "リライト"
      click_on "Search"
      expect(page).to have_content "ASIAN KUNG-FU GENERATION"
    end

    it "SpotifyとYoutubeのURLを表示する" do
      visit root_path
      fill_in "query", with: "リライト"
      click_on "Search"
      expect(page).to have_selector ".spotify-url", text: "https://open.spotify.com/track/3h5e4tpgR9q0cjQXzo8FMD?si=WN7JPlJ5SuSQhrhh9Z-8Yw"
      expect(page).to have_selector ".youtube-url", text: "https://youtu.be/cr8magEp0Ho"
    end
  end
end
