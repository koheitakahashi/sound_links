# frozen_string_literal: true

module ExternalService
  class Kkbox < Base
    def initialize(keyword:, offset: DEFAULT_OFFSET_NUMBER)
      super
    end

    def search
      return [] if keyword.blank?

      @response = ExternalService::Request.new.get(
        url: SoundLinksConstants::KKBOX_SEARCH_URL,
        headers: { Authorization: "Bearer #{access_token}" },
        params: { q: keyword, type: 'track', territory: 'JP', limit: SEARCH_TRACKS_NUMBER, offset: offset }
      )

      raise_external_service_error(response: @response) if @response.status_code != OK_STATUS_CODE
      build_sounds(@response.body)
    end

    private
      def access_token
        return @access_token if @access_token

        response = ExternalService::Request.new.post(
          url: SoundLinksConstants::KKBOX_AUTH_URL,
          body: "grant_type=client_credentials&client_id=#{SoundLinksConstants::KKBOX_API_KEY}&client_secret=#{SoundLinksConstants::KKBOX_API_SECRET_KEY}"
        )

        raise_external_service_error(response: response) if response.status_code != OK_STATUS_CODE
        response.body['access_token']
      end

      def build_sounds(response)
        return [] unless results = response.dig('tracks', 'data')

        results.map do |result|
          Sound.new(
            isrc: result['isrc'],
            # NOTE: height = 160, width = 160 のサムネイルを取得するためにインデックス0番目の URL を取得する
            thumbnail_url: result['album']['images'][0]['url'],
            title: result['name'],
            artist: result['album']['artist']['name'],
            kkbox_url: result['url']
          )
        end.uniq { |sound| sound.isrc }
      end

      def raise_external_service_error(response:)
        error_message = response.body.dig('error', 'message')
        raise ExternalService::Error.new, "There was an error connecting with the KKBOX API. HTTP Status Code: #{response.status_code}, Error message: #{error_message}"
      end
  end
end
