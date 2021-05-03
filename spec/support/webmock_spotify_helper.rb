# frozen_string_literal: true

module WebmockSpotifyHelper
  WebMock.enable!

  def mock_spotify_search_results
    WebMock.stub_request(:post, "https://accounts.spotify.com/api/token")
           .to_return(
             body: { access_token: "aaaa" }.to_json,
             status: 200,
             headers: { "Content-Type" =>  "application/json" }
           )

    WebMock.stub_request(:get, "https://api.spotify.com/v1/search?limit=10&offset=0&market=JP&q=リライト&type=track")
           .to_return(body: file_fixture("spotify_api_response.json"),
                      status: 200,
                      headers: { "Content-Type" =>  "application/json" })
  end

  def mock_spotify_search_results_without_page
    WebMock.stub_request(:post, "https://accounts.spotify.com/api/token")
           .to_return(
             body: { access_token: "aaaa" }.to_json,
             status: 200,
             headers: { "Content-Type" =>  "application/json" }
           )

    WebMock.stub_request(:get, "https://api.spotify.com/v1/search?limit=10&offset=0&market=JP&q=リライト&type=track")
           .to_return(body: file_fixture("spotify_api_response.json"),
                      status: 200,
                      headers: { "Content-Type" =>  "application/json" })

  end

  def mock_spotify_error_response
    WebMock.stub_request(:post, "https://accounts.spotify.com/api/token")
           .to_return(body: file_fixture("spotify_api_response_when_error.json"),
                      status: 401,
                      headers: { "Content-Type" =>  "application/json" })

    WebMock.stub_request(:get, "https://api.spotify.com/v1/search?limit=10&offset=0&market=JP&q=bad_params&type=track")
           .to_return(body: file_fixture("spotify_api_response_when_error.json"),
                      status: 401,
                      headers: { "Content-Type" =>  "application/json" })
  end
end
