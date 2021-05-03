# frozen_string_literal: true

class SearchesController < ApplicationController
  def index
    results = SoundSearcher.execute!(keyword: params[:keyword], page: params[:page].to_i)

    respond_to do |format|
      format.html { render "home/index" }
      format.json { render json: { results: results, current_page: results.current_page }, status: :ok }
    end
  end
end
