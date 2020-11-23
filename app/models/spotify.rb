# frozen_string_literal: true

class Spotify
  AUTH_URI = "https://accounts.spotify.com/api/token"
  SEARCH_URI = "https://api.spotify.com/v1/search?"

  SEARCH_TRACKS_NUMBER = 5

  def search(keyword)
    search_uri = URI.parse(SEARCH_URI + { q: keyword, type: "track", market: "JP", limit: SEARCH_TRACKS_NUMBER }.to_query)
    search_request = Net::HTTP::Get.new(search_uri)

    search_request["Authorization"] = "Bearer #{access_token}"

    response = receive_response(search_uri, search_request)
    format_responses(response)
  end

  private
    def authorization_key
      Base64.encode64("#{SoundLinksConstants::SPOTIFY_API_KEY}:#{SoundLinksConstants::SPOTIFY_API_SECRET_KEY}").gsub(/[\r\n]/, "")
    end

    def request_schema(uri)
      { use_ssl: uri.scheme == "https" }
    end

    def receive_response(uri, request)
      Net::HTTP.start(uri.hostname, uri.port, request_schema(uri)) do |http|
        http.request(request)
      end
    end

    def access_token
      auth_uri = URI.parse(AUTH_URI)
      auth_request = Net::HTTP::Post.new(auth_uri)

      auth_request["Authorization"] = "Basic #{authorization_key}"
      auth_request.set_form_data({ "grant_type" => "client_credentials" })

      auth_response = receive_response(auth_uri, auth_request)
      JSON.parse(auth_response.body)["access_token"]
    end

    def format_responses(response)
      formatted_responses = JSON.parse(response.body)["tracks"]["items"].map do |item|
        {
          isrc: item["external_ids"]["isrc"],
          title: item["name"],
          artist: item["artists"][0]["name"],
          spotify_url: item["external_urls"]["spotify"],
        }
      end
      formatted_responses.uniq { |item| item[:isrc] }
    end
end
