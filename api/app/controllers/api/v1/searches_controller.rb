# frozen_string_literal: true

module API
  module V1
    class SearchesController < ApplicationController
      def index
        @results = SoundSearcher.execute!(keyword: params[:keyword], page: params[:page].to_i)
        render "index", formats: :json
      end
    end
  end
end
