# frozen_string_literal: true

class API::SearchController < ApplicationController
  def index
    # TODO 検索フォームが空の時にエラーを表示するなどの処理を加えること
    keywords = params[:keywords]

    if keywords.blank?
      return render json: {}
    end

    results = SoundSearcher.new.search(keywords)
    render json: results
  end
end
