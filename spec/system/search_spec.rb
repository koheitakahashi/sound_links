# frozen_string_literal: true

require "rails_helper"
require "support/webmock_spotify_api_helpers.rb"

describe "楽曲検索機能", type: :system do
  include WebmockSpotifyApiHelpers

  context "検索フォームに入力した楽曲をSpotify APIを介して検索" do
    before do
      mock_search_results
    end

    it "検索結果を表示する" do
      visit root_path
      fill_in "query", with: "リライト"
      click_on "Search"
      expect(page).to have_content "ASIAN KUNG-FU GENERATION"
    end
  end
end
