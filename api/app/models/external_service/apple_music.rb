# frozen_string_literal: true

module ExternalService
  class AppleMusic < Base
    EXPIRED_TIME = 3600

    def initialize(keyword:, offset: DEFAULT_OFFSET_NUMBER)
      super
    end

    def search
      return [] if keyword.blank?

      @response = ExternalService::Request.new.get(
        url: SoundLinksConstants::APPLE_MUSIC_SEARCH_URL,
        headers: { Authorization: "Bearer #{authentication_token}" },
        params: { term: keyword, limit: SEARCH_TRACKS_NUMBER, types: 'songs', offset: offset }
      )

      raise_external_service_error(response: @response) if @response.status_code != OK_STATUS_CODE
      build_sounds(@response.body)
    end

    private
      def authentication_payload
        { iss: SoundLinksConstants::APPLE_MUSIC_TEAM_ID,
          iat: Time.now.to_i,
          exp: Time.now.to_i + EXPIRED_TIME }
      end

      def authentication_token
        return @authentication_token if @authentication_token

        private_key = OpenSSL::PKey::EC.new(SoundLinksConstants::APPLE_MUSIC_API_SECRET_KEY)
        @authentication_token = JWT.encode(authentication_payload, private_key, 'ES256', kid: SoundLinksConstants::APPLE_MUSIC_API_KEY)
      end

      # TODO: 共通化したい
      def build_sounds(response)
        return [] unless (results = response.dig('results', 'songs', 'data'))

        results.map do |result|
          Sound.new(
            isrc: result['attributes']['isrc'],
            thumbnail_url: format_artwork_url(result['attributes']['artwork']['url']),
            title: result['attributes']['name'],
            artist: result['attributes']['artistName'],
            apple_music_url: result['attributes']['url'],
          )
        end.uniq { |sound| sound.isrc }
      end

      def format_artwork_url(artwork_url)
        artwork_url.gsub(/{w}|{h}/, '300')
      end

      def raise_external_service_error(response:)
        error_message = response.body.dig('errors').first
        raise ExternalService::Error.new, "There was an error connecting with the AppleMusic API. HTTP Status Code: #{response.status_code}, Error message: #{error_message["title"]}, #{error_message["detail"]}"
      end
  end
end
