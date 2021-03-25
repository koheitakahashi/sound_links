# frozen_string_literal: true

require "rails_helper"

RSpec.describe "楽曲検索機能", type: :system do
  before do
    mock_search_results
  end

  it "検索した楽曲のSpotify・Apple Music・KKBOXのURLを表示できる" do
    visit root_path
    find(:test, "search-form").set("リライト")
    find(:test, "search-submit-button").click

    expect(all(:test, "title")[0].text).to have_content "リライト"
    expect(all(:test, "artist")[0].text).to have_content "ASIAN KUNG-FU GENERATION"
    expect(all(:test, "spotify-url")[0][:href]).to eq "https://open.spotify.com/track/3h5e4tpgR9q0cjQXzo8FMD?si=WN7JPlJ5SuSQhrhh9Z-8Yw"
    expect(all(:test, "apple-music-url")[0][:href]).to eq "https://music.apple.com/jp/album/%E3%83%AA%E3%83%A9%E3%82%A4%E3%83%88/570003767?i=570003920"
    expect(all(:test, "kkbox-url")[0][:href]).to eq "https://www.kkbox.com/jp/ja/song/FcqGD-90I.n6HlVI7lVI70P4-index.html"
  end

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
