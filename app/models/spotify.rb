# frozen_string_literal: true

class Spotify
  SEARCH_TRACKS_NUMBER = 5

  def search(keyword)
    response = Faraday.get(SoundLinksConstants::SPOTIFY_SEARCH_URL) do |request|
      request.params = { q: keyword, type: "track", market: "JP", limit: SEARCH_TRACKS_NUMBER }
      request.headers["Authorization"] = "Bearer #{access_token}"
    end

    format_response(response)
  end

  private
    def access_token
      response = Faraday.post(SoundLinksConstants::SPOTIFY_AUTH_URL, { grant_type: "client_credentials" }, { Authorization: "Basic #{authorization_key}" })
      JSON.parse(response.body)["access_token"]
    end

    def authorization_key
      Base64.encode64("#{SoundLinksConstants::SPOTIFY_API_KEY}:#{SoundLinksConstants::SPOTIFY_API_SECRET_KEY}").gsub(/[\r\n]/, "")
    end

    def format_response(response)
      JSON.parse(response.body)["tracks"]["items"].map do |item|
        {
          isrc: item["external_ids"]["isrc"],
          title: item["name"],
          artist: item["artists"][0]["name"],
          spotify_url: item["external_urls"]["spotify"],
        }
      end.uniq { |item| item[:isrc] }
    end
end
