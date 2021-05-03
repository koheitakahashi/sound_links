# frozen_string_literal: true

module WebmockAppleMusicHelper
  WebMock.enable!

  def mock_apple_music_search_results
    WebMock.stub_request(:get, "https://api.music.apple.com/v1/catalog/jp/search?limit=10&offset=0&term=リライト&types=songs")
           .to_return(status: 200,
                      body: file_fixture("apple_music_api_response.json"),
                      headers: { "Content-Type" =>  "application/json" })
  end

  def mock_apple_music_search_results_without_page
    WebMock.stub_request(:get, "https://api.music.apple.com/v1/catalog/jp/search?limit=10&offset=0&term=リライト&types=songs")
           .to_return(status: 200,
                      body: file_fixture("apple_music_api_response.json"),
                      headers: { "Content-Type" =>  "application/json" })
  end

  def mock_apple_music_error_response
    WebMock.stub_request(:get, "https://api.music.apple.com/v1/catalog/jp/search?limit=10&offset=0&term=bad_params&types=songs")
           .to_return(status: 401, body: file_fixture("apple_music_api_error_response.json"))
  end
end
