# frozen_string_literal: true

require "spec_helper"
require "rails_helper"
require "webmock/rspec"
require "support/webmock_spotify_api_helper.rb"

describe "SpotifyRepositoryのmodelテスト", type: :model do
  include WebmockSpotifyApiHelper
  describe "APIレスポンス(mock)を取得する" do
    before do
      mock_spotify_search_results
    end

    it "#search" do
      spotify = SpotifyRepository.new
      actual = spotify.search("リライト").first[:spotify_title]

      expect("リライト").to eq actual
    end
  end
end
