# frozen_string_literal: true

module ExternalService
  class Request
    TIME_OUT_SECOND = 120

    def initialize
    end

    def get(url:, headers:, params:)
      Rails.logger.info("** url = [#{url}]")
      Rails.logger.info("** params = [#{params}]")

      response = client.get(url) do |request|
        request.headers = headers
        request.params = params
      end

      ExternalService::Response.new(response.body)
    end

    def post(url:, headers: nil, body: nil)
      response = client.post(url) do |request|
        request.headers = headers if headers.present?
        request.body = body if body.present?
      end

      ExternalService::Response.new(response.body)
    end

    private
      def client
        @client ||= Faraday.new do |connection|
          connection.response :logger
          connection.adapter :net_http
          connection.options[:timeout] = TIME_OUT_SECOND
        end
      end
  end
end
