# frozen_string_literal: true

module ExternalService
  class Spotify < Base
    def search(keyword)
      return [] if keyword.blank?

      @response = ExternalService::Request.new.get(
        url: SoundLinksConstants::SPOTIFY_SEARCH_URL,
        headers: { Authorization: "Bearer #{access_token}" },
        params: { q: keyword, type: "track", market: "JP", limit: SEARCH_TRACKS_NUMBER }
      )

      raise_external_service_error(response: @response) if @response.status_code != 200
      format_response(@response.body)
    end


    private
      def access_token
        return @access_token if @access_token

        @response = ExternalService::Request.new.post(
          url: SoundLinksConstants::SPOTIFY_AUTH_URL,
          body: "grant_type=client_credentials",
          headers: { Authorization: "Basic #{authorization_key}" }
        )

        raise_external_service_error(response: @response) if @response.status_code != 200
        @access_token = @response.body["access_token"]
      end

      def authorization_key
        Base64.encode64("#{SoundLinksConstants::SPOTIFY_API_KEY}:#{SoundLinksConstants::SPOTIFY_API_SECRET_KEY}").gsub(/[\r\n]/, "")
      end

      def format_response(response)
        response.dig("tracks", "items").map do |item|
          { isrc: item["external_ids"]["isrc"],
            # height = 300, width = 300 のサムネイルを取得するためにインデックス1の url を取得
            thumbnail: item["album"]["images"][1]["url"],
            title: item["name"],
            artist: item["artists"][0]["name"],
            spotify_url: item["external_urls"]["spotify"] }
        end.uniq { |item| item[:isrc] }
      end

      def raise_external_service_error(response:)
        error_message = response.body.dig("error", "message")
        raise ExternalService::Error.new, "There was an error connecting with the Spotify API. HTTP Status Code: #{@response.status_code}, Response error message: #{error_message}"
      end
  end
end
