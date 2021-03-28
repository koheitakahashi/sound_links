# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    # TODO 検索フォームが空の時にエラーを表示するなどの処理を加えること
    keywords = params[:keywords]

    if keywords.blank?
      return render json: {}
    end

    @results = SoundSearcher.new.search(keywords)

    respond_to do |format|
      format.html { render "home/index" }
      format.json { render json: @results, status: :ok }
    end
  end
end
