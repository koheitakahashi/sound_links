# frozen_string_literal: true

module ExternalService
  class Spotify < Base
    def search(keyword)
      response = ExternalService::Request.new.get(
        url: SoundLinksConstants::SPOTIFY_SEARCH_URL,
        headers: { Authorization: "Bearer #{access_token}" },
        params: { q: keyword, type: "track", market: "JP", limit: SEARCH_TRACKS_NUMBER }
      )
      format_response(response.body)
    end


    private
      def access_token
        response = ExternalService::Request.new.post(
          url: SoundLinksConstants::SPOTIFY_AUTH_URL,
          body: "grant_type=client_credentials",
          headers: { Authorization: "Basic #{authorization_key}" },
        )
        response.body["access_token"]
      end

      def authorization_key
        Base64.encode64("#{SoundLinksConstants::SPOTIFY_API_KEY}:#{SoundLinksConstants::SPOTIFY_API_SECRET_KEY}").gsub(/[\r\n]/, "")
      end

      def format_response(response)
        response["tracks"]["items"].map do |item|
          {
            isrc: item["external_ids"]["isrc"],
            title: item["name"],
            artist: item["artists"][0]["name"],
            spotify_url: item["external_urls"]["spotify"],
          }
        end.uniq { |item| item[:isrc] }
      end
  end
end
