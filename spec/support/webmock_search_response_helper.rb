# frozen_string_literal: true

require "support/webmock_spotify_helper"
require "support/webmock_apple_music_helper"
require "support/webmock_youtube_helper"

include WebmockSpotifyHelper
include WebmockYoutubeHelper
include WebmockAppleMusicHelper

module WebmockSearchResponseHelper
  def mock_apis_search_results
    mock_spotify_search_results
    mock_apple_music_search_results
    mock_youtube_search_results
  end
end
