# frozen_string_literal: true

require "google/apis/youtube_v3"

class YoutubeApiRepository
  GOOGLE_API_KEY= Rails.application.credentials.google[:api_key]
  YOUTUBE_URL = "https://youtu.be/"

  SEARCH_TRACKS_NUMBER = 10

  def search(query)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY

    response = service.list_searches(:snippet, request_options(query))

    # TODO メソッド名が他のクラスと異なるため、統一すること
    trim_response_data(response)
  end

  private

    def trim_response_data(response)
      response.items.map { |item| format(item) if check_license(item.id.video_id) }.compact
    end

    def check_license(id)
      service = Google::Apis::YoutubeV3::YouTubeService.new
      service.key = GOOGLE_API_KEY

      response = service.list_videos(:content_details, id: id, fields: "items(content_details(licensed_content))")

      str_license = response.items.map { |item| item.content_details.licensed_content }.join("")
      # str_licenseが文字列のためbooleanに変換している
      @license = ActiveRecord::Type::Boolean.new.cast(str_license)
    end

    # TODO 無意味にインスタンス変数を使っているため修正すること
    def format(item)
      {
        title: item.snippet.title,
        artist: item.snippet.channel_title,
        youtube_url: url(item),
        youtube_license: @license
      }
    end

    def request_options(query)
      {
        q: query,
        type: "video",
        max_results: SEARCH_TRACKS_NUMBER,
        video_category_id: "10",
        video_license: "youtube",
        fields: "items(id(video_id), snippet(title, channel_title))"
      }
    end

    def url(item)
      item.nil? ? nil : YOUTUBE_URL + item.id.video_id
    end
end
