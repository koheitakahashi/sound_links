# frozen_string_literal: true

module ExternalService
  class Kkbox < Base
    def search(keyword)
      return [] if keyword.blank?

      @response = ExternalService::Request.new.get(
        url: SoundLinksConstants::KKBOX_SEARCH_URL,
        headers: { Authorization: "Bearer #{access_token}" },
        params: { q: keyword, type: "track", territory: "JP", limit: SEARCH_TRACKS_NUMBER }
      )

      raise_external_service_error(response: @response) if @response.status_code != 200
      format_response(@response.body)
    end

    private
      def access_token
        return @access_token if @access_token

        response = ExternalService::Request.new.post(
          url: SoundLinksConstants::KKBOX_AUTH_URL,
          body: "grant_type=client_credentials&client_id=#{SoundLinksConstants::KKBOX_API_KEY}&client_secret=#{SoundLinksConstants::KKBOX_API_SECRET_KEY}"
        )

        raise_external_service_error(response: response) if response.status_code != 200
        response.body["access_token"]
      end

      def format_response(response)
        response["tracks"]["data"].map do |item|
          { isrc: item["isrc"],
            # NOTE: height = 160, width = 160 のサムネイルを取得するためにインデックス0番目の URL を取得する
            thumbnail: item["album"]["images"][0]["url"],
            title: item["name"],
            artist: item["album"]["artist"]["name"],
            kkbox_url: item["url"] }
        end.uniq { |item| item[:isrc] }
      end

      def raise_external_service_error(response:)
        error_message = response.body.dig("error", "message")
        raise ExternalService::Error.new, "There was an error connecting with the KKBOX API. HTTP Status Code: #{response.status_code}, Error message: #{error_message}"
      end
  end
end
