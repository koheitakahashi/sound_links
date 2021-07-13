# frozen_string_literal: true

module API
  module V1
    class SearchesController < ApplicationController
      def index
        results = SoundSearcher.execute!(keyword: params[:keyword], page: params[:page].to_i)
        render json: { results: results.as_json, current_page: results.current_page }, status: :ok
      end
    end
  end
end
