# frozen_string_literal: true

module API
  module V1
    class SearchesController < ApplicationController
      def index
        return render json: { results: [], current_page: 1 } if params[:keyword].blank?

        @results = SoundSearcher.execute!(keyword: params[:keyword], page: params[:page].to_i)
        render "index", formats: :json
      end
    end
  end
end
