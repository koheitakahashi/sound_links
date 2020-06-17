# frozen_string_literal: true

require "spec_helper"
require "rails_helper"
require "webmock/rspec"
require "support/webmock_apple_music_api_helper"

describe "AppelMusicRepositoryのmodelテスト", type: :model do
  include WebmockAppleMusicApiHelper

  describe "APIレスポンス(mock)を取得する" do
    before do
      mock_apple_music_search_results
    end

    it "#search" do
      apple_music = AppleMusicRepository.new
      actual = apple_music.search("リライト")
      expected = [
        {
          apple_music_title: "リライト",
          apple_music_artists: "ASIAN KUNG-FU GENERATION",
          apple_music_url: "https://music.apple.com/jp/album/%E3%83%AA%E3%83%A9%E3%82%A4%E3%83%88/570003767?i=570003920"
        }
      ]

      expect(expected).to eq actual
    end
  end
end
