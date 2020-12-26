# frozen_string_literal: true

class API::SearchController < ApplicationController
  def index
    # TODO 検索フォームが空の時にエラーを表示するなどの処理を加えること
    keywords = params[:keywords]
    return unless keywords.present?

    render json: SoundSearcher.new.search(keyword)
  end
end
