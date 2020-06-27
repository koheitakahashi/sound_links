# frozen_string_literal: true

class ResultsController < ApplicationController
  def index
    # TODO 検索フォームが空の時にエラーを表示するなどの処理を加えること
    keyword = params[:keyword]
    return unless keyword.present?

    sounds_api = SoundApisRepository.new
    @results = sounds_api.search(keyword)
  end
end
