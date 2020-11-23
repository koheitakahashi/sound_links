# frozen_string_literal: true

class Kkbox
  API_KEY        = Rails.application.credentials.kkbox[:client_id]
  API_SECRET_KEY = Rails.application.credentials.kkbox[:client_secret]

  AUTH_URI   = "https://account.kkbox.com/oauth2/token"
  SEARCH_URI = "https://api.kkbox.com/v1.1/search?"

  SEARCH_TRACKS_NUMBER = 5

  def search(keyword)
    search_uri                      = URI.parse(SEARCH_URI + {q: keyword, type: "track", territory: "JP", limit: SEARCH_TRACKS_NUMBER}.to_query)
    search_request                  = Net::HTTP::Get.new(search_uri)
    search_request["Authorization"] = "Bearer #{access_token}"

    format_responses(receive_response(search_uri, search_request))
  end

  private

    def receive_response(uri, request)
      req_options = {use_ssl: uri.scheme == "https", }
      Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
    end

    def access_token
      uri     = URI.parse(AUTH_URI)
      request = Net::HTTP::Post.new(uri)
      request.set_form_data({grant_type: "client_credentials", client_id: API_KEY, client_secret: API_SECRET_KEY})

      req_options = {use_ssl: uri.scheme == "https", }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      JSON.parse(response.body)["access_token"]
    end

    def format_responses(response)
      result              = Struct.new(:isrc, :title, :artist, :kkbox_url)
      formatted_responses = JSON.parse(response.body)["tracks"]["data"].map do |item|
        result.new(
          item["isrc"],
          item["name"],
          item["album"]["artist"]["name"],
          item["url"],
        )
      end
      uniq_by_isrc(formatted_responses)
    end

    def uniq_by_isrc(array)
      array.uniq { |item| item.isrc }
    end
end
