# frozen_string_literal: true

class SearchesController < ApplicationController
  def index
    keyword = params[:keyword]

    results = SoundSearcher.execute!(keyword)

    respond_to do |format|
      format.html { render "home/index" }
      format.json { render json: results, status: :ok }
    end
  end
end
