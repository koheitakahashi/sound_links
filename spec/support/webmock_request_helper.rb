# frozen_string_literal: true

module WebmockRequestHelper
  WebMock.enable!

  def mock_get_request
    WebMock.stub_request(:get, "https://api.spotify.com/v1/search?limit=5&market=JP&q=リライト&type=track")
           .with(headers: { Authorization: "Bearer NEW_ACCESS_TOKEN" })
           .to_return(status: 200,
                      body: file_fixture("get_request_response.json"),
                      headers: {})
  end

  def mock_post_request
    WebMock.stub_request(:post, "https://accounts.spotify.com/api/token")
           .with(headers: { Authorization: "Basic authorization_key" },
                 body: "grant_type=client_credentials")
           .to_return(status: 200,
                      body: file_fixture("post_request_response.json"),
                      headers: {})
  end
end
