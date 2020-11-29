# frozen_string_literal: true

class AppleMusic
  SEARCH_TRACKS_NUMBER = 5

  def search(keyword)
    response = Faraday.get(SoundLinksConstants::APPLE_MUSIC_SEARCH_URL) do |request|
      request.params = { term: keyword, limit: SEARCH_TRACKS_NUMBER, types: "songs" }
      request.headers["Authorization"] = "Bearer #{authentication_token}"
    end

    format_response(response)
  end

  private
    def authentication_payload
      {
        iss: SoundLinksConstants::APPLE_MUSIC_TEAM_ID,
        iat: Time.now.to_i,
        exp: Time.now.to_i + 3600
      }
    end

    def authentication_token
      private_key = OpenSSL::PKey::EC.new(SoundLinksConstants::APPLE_MUSIC_API_SECRET_KEY)
      JWT.encode(authentication_payload, private_key, "ES256", kid: SoundLinksConstants::APPLE_MUSIC_API_KEY)
    end

    def format_response(response)
      JSON.parse(response.body)["results"]["songs"]["data"].map do |item|
        {
          isrc: item["attributes"]["isrc"],
          title: item["attributes"]["name"],
          artist: item["attributes"]["artistName"],
          apple_music_url: item["attributes"]["url"]
        }
      end.uniq { |item| item[:isrc] }
    end
end
