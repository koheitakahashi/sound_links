# frozen_string_literal: true

module ExternalService
  class Kkbox
    SEARCH_TRACKS_NUMBER = 5

    def search(keyword)
      response = Faraday.get(SoundLinksConstants::KKBOX_SEARCH_URL) do |request|
        request.params = { q: keyword, type: "track", territory: "JP", limit: SEARCH_TRACKS_NUMBER }
        request.headers["Authorization"] = "Bearer #{access_token}"
      end

      format_response(response)
    end

    private
      def access_token
        response = Faraday.post(SoundLinksConstants::KKBOX_AUTH_URL,
                                { grant_type: "client_credentials",
                                  client_id: SoundLinksConstants::KKBOX_API_KEY,
                                  client_secret: SoundLinksConstants::KKBOX_API_SECRET_KEY })
        JSON.parse(response.body)["access_token"]
      end

      def format_response(response)
        JSON.parse(response.body)["tracks"]["data"].map do |item|
          {
            isrc: item["isrc"],
            title: item["name"],
            artist: item["album"]["artist"]["name"],
            kkbox_url: item["url"],
          }
        end.uniq { |item| item[:isrc] }
      end
  end
end
