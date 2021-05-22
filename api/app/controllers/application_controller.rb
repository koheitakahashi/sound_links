# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ExternalService::Error, with: :render_500

  private
    def render_500(error)
      Rails.logger.error("internal server error（500）because: #{error.message}")
      # TODO: エラーレスポンスを検討して修正する
      render file: "/public/500.html", status: :internal_server_error
    end
end
