# frozen_string_literal: true

require "support/webmock_spotify_api_helper"
require "support/webmock_apple_music_api_helper"
require "support/webmock_youtube_api_helper"

include WebmockSpotifyApiHelper
include WebmockYoutubeApiHelper
include WebmockAppleMusicApiHelper

module WebmockApisResponseHelper
  def mock_apis_search_results
    mock_spotify_search_results
    mock_apple_music_search_results
    mock_youtube_search_results
  end
end
