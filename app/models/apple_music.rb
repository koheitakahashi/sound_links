# frozen_string_literal: true

class AppleMusic
  API_KEY =  Rails.application.credentials.apple_music[:key_id]
  API_SECRET_KEY = Rails.application.credentials.apple_music[:private_key]
  APPLE_TEAM_ID = Rails.application.credentials.apple_music[:team_id]

  SEARCH_URL = "https://api.music.apple.com/v1/catalog/jp/search?"
  SEARCH_TRACKS_NUMBER = 5

  def search(keyword)
    search_uri = URI.parse(SEARCH_URL + { term: keyword, limit: SEARCH_TRACKS_NUMBER, types: "songs" }.to_query)

    search_request = Net::HTTP::Get.new(search_uri)
    search_request["Authorization"] = "Bearer #{authentication_token}"

    response = receive_response(search_uri, search_request)

    format_responses(response)
  end

  private
    # TODO spotify.rbとほぼ同じ構造なので、モジュールに切り分けること
    def receive_response(uri, request)
      Net::HTTP.start(uri.hostname, uri.port, request_schema(uri)) do |http|
        http.request(request)
      end
    end

    def request_schema(uri)
      { use_ssl: uri.scheme == "https" }
    end

    def authentication_payload
      {
        iss: APPLE_TEAM_ID,
        iat: Time.now.to_i,
        exp: Time.now.to_i + 3600
      }
    end

    def authentication_token
      private_key = OpenSSL::PKey::EC.new(API_SECRET_KEY)
      JWT.encode(authentication_payload, private_key, "ES256", kid: API_KEY)
    end

    def format_responses(response)
      result = Struct.new(:isrc, :title, :artist, :apple_music_url)
      formatted_responses = JSON.parse(response.body)["results"]["songs"]["data"].map do |item|
        result.new(
          item["attributes"]["isrc"],
          item["attributes"]["name"],
          item["attributes"]["artistName"],
          item["attributes"]["url"]
        )
      end
      formatted_responses.uniq { |item| item.isrc }
    end

    def uniq_by_isrc(array)
      array.uniq { |item| item.isrc }
    end
end
