# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ExternalService::Error, with: :response_500

  private
    def response_500(error)
      Rails.logger.error("Internal server error（500）because: #{error.message}")
      render json: { errors: { message: "Internal server error." } }, status: :internal_server_error
    end

    # NOTE: frontend アプリからではなく、ブラウザから直接URLを叩かれたときに検索結果を返したくないため、リクエストをチェックしている。
    def validate_request
      if request.headers["Content-Type"] != "application/json" || request.headers["X-Requested-By"] != "https://sound-links.com"
        render json: { errors: { message: "Request is inappropriate." } }, status: :unauthorized
      end
    end
end
