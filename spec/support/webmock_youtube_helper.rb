# frozen_string_literal: true

module WebmockYoutubeHelper
  WebMock.enable!
  GOOGLE_API_KEY= Rails.application.credentials.google[:api_key]

  def mock_youtube_search_results
    WebMock.stub_request(:get, "https://www.googleapis.com/youtube/v3/search?fields=items(id(videoId),%20snippet(title,%20channelTitle))&key=#{GOOGLE_API_KEY}&maxResults=10&part=snippet&q=%E3%83%AA%E3%83%A9%E3%82%A4%E3%83%88&type=video&videoCategoryId=10&videoLicense=youtube")
       .to_return(status: 200,
                  body: File.read("#{Rails.root}/spec/fixtures/youtube_api_response.json"),
                  headers: { "Content-Type"=> "application/json" }
       )

    WebMock.stub_request(:get, "https://www.googleapis.com/youtube/v3/videos?fields=items(contentDetails(licensedContent))&id=cr8magEp0Ho&key=#{GOOGLE_API_KEY}&part=content_details")
      .to_return(status: 200,
                 body: File.read("#{Rails.root}/spec/fixtures/youtube_api_license_response.json"),
                 headers: { "Content-Type"=> "application/json" }
      )

    WebMock.stub_request(:get, "https://www.googleapis.com/youtube/v3/videos?fields=items(contentDetails(licensedContent))&id=bOZixNTn_ck&key=#{GOOGLE_API_KEY}&part=content_details")
      .to_return(status: 200,
                 body: File.read("#{Rails.root}/spec/fixtures/youtube_api_license_response.json"),
                 headers: { "Content-Type"=> "application/json" }
      )
  end
end
