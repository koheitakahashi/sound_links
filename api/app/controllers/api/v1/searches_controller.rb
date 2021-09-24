# frozen_string_literal: true

module API
  module V1
    # TODO: リクエストスペックを書く
    class SearchesController < ApplicationController
      DEFAULT_CURRENT_PAGE = 1

      def index
        return render json: { results: [], current_page: DEFAULT_CURRENT_PAGE } if params[:keyword].blank?

        @results = SoundSearcher.execute!(keyword: params[:keyword], page: params[:page].to_i)
        render "index", formats: :json
      end
    end
  end
end
