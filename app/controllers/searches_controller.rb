# frozen_string_literal: true

class SearchesController < ApplicationController
  def index
  end

  def show
    # TODO 検索フォームが空の時にエラーを表示するなどの処理を加えること
    keyword = params[:keyword]
    return unless keyword.present?

    # TODO 複数のAPIからのレスポンスを曲名、アーティス名を参照して統合して表示できるようにすること
    sounds_api = SoundApisRepository.new
    @results = sounds_api.search(keyword)
  end
end
