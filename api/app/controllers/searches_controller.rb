# frozen_string_literal: true

class SearchesController < ApplicationController
  def index
    respond_to do |format|
      format.html { render "home/index" }
      format.json { render_searched_sounds_json }
    end
  end

  private
    def render_searched_sounds_json
      results = SoundSearcher.execute!(keyword: params[:keyword], page: params[:page].to_i)
      render json: { results: results.as_json, current_page: results.current_page }, status: :ok
    end
end
