# frozen_string_literal: true

require "spec_helper"
require "rails_helper"
require "webmock/rspec"
require "support/webmock_youtube_api_helper"

describe "YoutubeRepositoryのmodelテスト", type: :model do
  include WebmockYoutubeApiHelper
  describe "APIレスポンス(mock)を取得する" do
    before do
      mock_youtube_search_results
    end

    it "#search" do
      youtube= YoutubeRepository.new
      actual = youtube.search("リライト")
      expected = [
        {
          youtube_title: "ASIAN KUNG-FU GENERATION　『リライト』",
          youtube_artists: "ASIAN KUNG-FU GENERATION Official YouTube Channel",
          youtube_url: "https://youtu.be/cr8magEp0Ho",
          youtube_license: true,
        }
      ]

      expect(expected).to eq actual
    end
  end
end
