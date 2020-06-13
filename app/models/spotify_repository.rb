# frozen_string_literal: true

class SpotifyRepository
  API_KEY = Rails.application.credentials.spotify[:client_id]
  API_SECRET_KEY = Rails.application.credentials.spotify[:client_secret]
  AUTH_URI = "https://accounts.spotify.com/api/token"
  SEARCH_URI = "https://api.spotify.com/v1/search?"
  AUTH_GRANT_TYPE = { "grant_type" => "client_credentials" }

  def search(params)
    search_uri = URI.parse(SEARCH_URI + { q: params, type: "track", market: "JP" }.to_query)
    search_request = Net::HTTP::Get.new(search_uri)

    search_request["Authorization"] = "Bearer #{access_token}"

    response = api_response(search_uri, search_request)

    # TODO 仮に検索結果から5つを取り出しているが、クエリを変更したり、他の処理に置き換えること
    format(response).take(5)
  end

  private
    def authorization_key
      Base64.encode64("#{API_KEY}:#{API_SECRET_KEY}").gsub(/[\r\n]/, "")
    end

    def request_schema(uri)
      { use_ssl: uri.scheme == "https" }
    end

    def api_response(uri, request)
      Net::HTTP.start(uri.hostname, uri.port, request_schema(uri)) do |http|
        http.request(request)
      end
    end

    def access_token
      auth_uri = URI.parse(AUTH_URI)
      auth_request = Net::HTTP::Post.new(auth_uri)

      auth_request["Authorization"] = "Basic #{authorization_key}"
      auth_request.set_form_data(AUTH_GRANT_TYPE)

      auth_response = api_response(auth_uri, auth_request)
      JSON.parse(auth_response.body)["access_token"]
    end

    def format(response)
      JSON.parse(response.body)["tracks"]["items"].map do |item|
        {
          spotify_title: item["name"],
          spotify_artists: item["artists"][0]["name"],
          spotify_url: item["external_urls"]["spotify"]
        }
      end
    end
end
