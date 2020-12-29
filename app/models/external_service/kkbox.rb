# frozen_string_literal: true

module ExternalService
  class Kkbox < Base
    def search(keyword)
      # TODO: keyword を escape する
      return [] if keyword.blank?

      response = ExternalService::Request.new.get(
        url: SoundLinksConstants::KKBOX_SEARCH_URL,
        headers: { Authorization: "Bearer #{access_token}" },
        params: { q: keyword, type: "track", territory: "JP", limit: SEARCH_TRACKS_NUMBER })

      format_response(response.body)
    end

    private
      def access_token
        return @access_token if @access_token

        response = ExternalService::Request.new.post(
          url: SoundLinksConstants::KKBOX_AUTH_URL,
          body: "grant_type=client_credentials&client_id=#{SoundLinksConstants::KKBOX_API_KEY}&client_secret=#{SoundLinksConstants::KKBOX_API_SECRET_KEY}")

        response.body["access_token"]
      end

      def format_response(response)
        response["tracks"]["data"].map do |item|
          { isrc: item["isrc"],
            # height = 160, width = 160 のサムネイルを取得するためにインデックス0番目の URL を取得する
            thumbnail: item["album"]["images"][0]["url"],
            title: item["name"],
            artist: item["album"]["artist"]["name"],
            kkbox_url: item["url"] }
        end.uniq { |item| item[:isrc] }
      end
  end
end
