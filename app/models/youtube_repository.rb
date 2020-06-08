# frozen_string_literal: true

require 'google/apis/youtube_v3'

class YoutubeRepository
  GOOGLE_API_KEY= Rails.application.credentials.google[:api_key]
  YOUTUBE_URL = "https://youtu.be/"

  def search(query)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY

    response = service.list_searches(:snippet, request_options(query))

    trim_response_data(response)
  end

  private
    def trim_response_data(response)
      response.items.map do |item|
        check_license(item.id.video_id) ? insert_format(item) : insert_format(nil)
      end
    end

    def check_license(id)
      service = Google::Apis::YoutubeV3::YouTubeService.new
      service.key = GOOGLE_API_KEY

      response = service.list_videos(:content_details, id: id, fields: "items(content_details(licensed_content))")

      str_license = response.items.map { |item| item.content_details.licensed_content }.join("")
      # str_licenseが文字列のためbooleanに変換している
      @license = ActiveRecord::Type::Boolean.new.cast(str_license)
    end

    def insert_format(item)
      {
        youtube_title: item&.snippet&.title,
        youtube_artists: item&.snippet&.channel_title,
        youtube_url: url(item),
        youtube_license: @license
      }
    end

    def request_options(query)
      {
        q: query,
        type: 'video',
        max_results: 10,
        video_category_id: "10",
        video_license: "youtube",
        fields: "items(id(video_id), snippet(title, channel_title))"
      }
    end

    def url(item)
      item.nil? ? nil : YOUTUBE_URL + item.id.video_id
    end
end