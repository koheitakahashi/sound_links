# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ExternalService::Error, with: :response_500

  private
    def response_500(error)
      Rails.logger.error("internal server error（500）because: #{error.message}")
      render json: { errors: { message: error.message }}, status: :internal_server_error
    end
end
