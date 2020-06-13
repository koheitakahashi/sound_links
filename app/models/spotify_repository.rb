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

    api_response(search_uri, search_request)
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
end
