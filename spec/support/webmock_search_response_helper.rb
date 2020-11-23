# frozen_string_literal: true

module WebmockSearchResponseHelper
  def mock_search_results
    mock_spotify_search_results
    mock_apple_music_search_results
    mock_kkbox_search_results
  end
end
