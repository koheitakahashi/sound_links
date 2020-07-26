# frozen_string_literal: true

require "google/apis/youtube_v3"

class Youtube
  GOOGLE_API_KEY= Rails.application.credentials.google[:api_key]
  YOUTUBE_URL = "https://youtu.be/"

  SEARCH_TRACKS_NUMBER = 10

  def search(query)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY

    response = service.list_searches(:snippet, request_options(query))

    format_responses(response)
  end

  private
    def format_responses(response)
      result = Struct.new(:title, :artist, :youtube_url, :youtube_license)
      formatted_responses = response.items.map do |item|
        result.new(
          item.snippet.title,
          item.snippet.channel_title,
          url(item),
          has_license?(item.id.video_id)
        )
      end
      delete_unlicensed_response(formatted_responses)
    end

    def delete_unlicensed_response(array)
      array.delete_if { |item| item.youtube_license === false }
    end

    def has_license?(id)
      service = Google::Apis::YoutubeV3::YouTubeService.new
      service.key = GOOGLE_API_KEY

      response = service.list_videos(:content_details, id: id, fields: "items(content_details(licensed_content))")

      str_license = response.items.map { |item| item.content_details.licensed_content }.join("")
      ActiveRecord::Type::Boolean.new.cast(str_license)
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
