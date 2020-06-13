# frozen_string_literal: true

require "spec_helper"
require "rails_helper"
require "webmock/rspec"
require "support/webmock_spotify_api_helpers.rb"

describe "SpotifyRepositoryのmodelテスト", type: :model do
  include WebmockSpotifyApiHelpers
  describe "APIレスポンス(mock)を取得する" do
    before do
      mock_search_results
    end

    it "#search" do
      spotify = SpotifyRepository.new
      response = spotify.search("リライト")
      actual = JSON.parse(response.body)["tracks"]["items"][0]["name"]

      expect("リライト").to eq actual
    end
  end
end
