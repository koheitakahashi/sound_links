# frozen_string_literal: true

module WebmockAppleMusicApiHelper
  WebMock.enable!

  def mock_apple_music_search_results
    WebMock.stub_request(:get, "https://api.music.apple.com/v1/catalog/jp/search?limit=5&term=%E3%83%AA%E3%83%A9%E3%82%A4%E3%83%88&types=songs")
      .to_return(status: 200,
                 body: File.read("#{Rails.root}/spec/fixtures/apple_music_api_response.json") ,
                 headers: { "Content-Type" =>  "application/json" }
      )
  end
end
