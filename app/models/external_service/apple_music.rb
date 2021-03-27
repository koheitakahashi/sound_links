# frozen_string_literal: true

module ExternalService
  class AppleMusic < Base
    def search(keyword)
      return [] if keyword.blank?

      @response = ExternalService::Request.new.get(
        url: SoundLinksConstants::APPLE_MUSIC_SEARCH_URL,
        headers: { Authorization: "Bearer #{authentication_token}" },
        params: { term: keyword, limit: SEARCH_TRACKS_NUMBER, types: "songs" }
      )

      raise_external_service_error(response: @response) if @response.status_code != 200
      format_response(@response.body)
    end

    private
      def authentication_payload
        { iss: SoundLinksConstants::APPLE_MUSIC_TEAM_ID,
          iat: Time.now.to_i,
          exp: Time.now.to_i + 3600 }
      end

      def authentication_token
        return @authentication_token if @authentication_token

        private_key = OpenSSL::PKey::EC.new(SoundLinksConstants::APPLE_MUSIC_API_SECRET_KEY)
        @authentication_token = JWT.encode(authentication_payload, private_key, "ES256", kid: SoundLinksConstants::APPLE_MUSIC_API_KEY)
      end

      def format_response(response)
        response.dig("results", "songs", "data").map do |item|
          { isrc: item["attributes"]["isrc"],
            thumbnail: format_artwork_url(item["attributes"]["artwork"]["url"]),
            title: item["attributes"]["name"],
            artist: item["attributes"]["artistName"],
            apple_music_url: item["attributes"]["url"] }
        end.uniq { |item| item[:isrc] }
      end

      def format_artwork_url(artwork_url)
        artwork_url.gsub(/{w}|{h}/, "300")
      end

      def raise_external_service_error(response:)
        error_message = response.body.dig("error")
        raise ExternalService::Error.new, "There was an error connecting with the AppleMusic API. HTTP Status Code: #{response.status_code}, Error message: #{error_message["title"]}, #{error_message["detail"]}"
      end
  end
end
