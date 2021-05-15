# frozen_string_literal: true

module WebmockSearchResponseHelper
  def mock_search_results
    mock_spotify_search_results
    mock_apple_music_search_results
    mock_kkbox_search_results
  end

  def mock_search_results_without_page
    mock_spotify_search_results_without_page
    mock_apple_music_search_results_without_page
    mock_kkbox_search_results_without_page
  end

  def mock_search_when_no_results
    mock_spotify_search_results_when_no_results
    mock_apple_music_search_results_when_no_results
    mock_kkbox_search_when_no_results
  end
end
