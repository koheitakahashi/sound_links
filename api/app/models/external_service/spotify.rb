# frozen_string_literal: true

module ExternalService
  class Spotify < Base
    def initialize(keyword:, offset: DEFAULT_OFFSET_NUMBER)
      super
    end

    def search
      return [] if keyword.blank?

      @response = ExternalService::Request.new.get(
        url: SoundLinksConstants::SPOTIFY_SEARCH_URL,
        headers: { Authorization: "Bearer #{access_token}" },
        params: { q: keyword, type: "track", market: "JP", limit: SEARCH_TRACKS_NUMBER, offset: offset }
      )

      raise_external_service_error(response: @response) if @response.status_code != 200
      build_sounds(@response.body)
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

      def build_sounds(response)
        return [] unless results = response.dig("tracks", "items")
        results.map do |result|
          Sound.new(
            isrc: result["external_ids"]["isrc"],
            # height = 300, width = 300 のサムネイルを取得するためにインデックス1の url を取得
            thumbnail_url: result["album"]["images"][1]["url"],
            title: result["name"],
            artist: result["artists"][0]["name"],
            spotify_url: result["external_urls"]["spotify"],
          )
        end.uniq { |sound| sound[:isrc] }
      end

      def raise_external_service_error(response:)
        error_message = response.body.dig("error", "message")
        raise ExternalService::Error.new, "There was an error connecting with the Spotify API. HTTP Status Code: #{@response.status_code}, Response error message: #{error_message}"
      end
  end
end
