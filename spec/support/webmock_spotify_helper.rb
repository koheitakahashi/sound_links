# frozen_string_literal: true

module WebmockSpotifyHelper
  WebMock.enable!
  WebMock.disable_net_connect!(
    allow_localhost: true,
    allow: "chromedriver.storage.googleapis.com"
  )

  def mock_spotify_search_results
    WebMock.stub_request(:post, "https://accounts.spotify.com/api/token")
      .to_return(
        body: { access_token: "aaaa" }.to_json,
        status: 200,
        headers: { "Content-Type" =>  "application/json" }
      )

    WebMock.stub_request(:get, "https://api.spotify.com/v1/search?limit=5&market=JP&q=%E3%83%AA%E3%83%A9%E3%82%A4%E3%83%88&type=track")
      .to_return(
        body: File.read("#{Rails.root}/spec/fixtures/spotify_api_response.json"),
        status: 200,
        headers: { "Content-Type" =>  "application/json" }
      )
  end
end
