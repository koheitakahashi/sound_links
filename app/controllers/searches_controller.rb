# frozen_string_literal: true

class SearchesController < ApplicationController
  def index
  end

  def show
    # TODO 検索フォームが空の時にエラーを表示するなどの処理を加えること
    query = params[:query]
    return unless query.present?

    # TODO 複数のAPIからのレスポンスを曲名、アーティス名を参照して統合して表示できるようにすること
    spotify = SpotifyRepository.new
    youtube = YoutubeRepository.new
    spotifay_response = spotify.search(query)
    youtube_response = youtube.search(query)
    @results = sounds_data(spotifay_response, youtube_response)
  end

  private
    # TODO mapを使った処理ができないかを考えること
    def sounds_data(spotifay_response, youtube_response)
      data = []
      spotifay_response.each_with_index do |s_res, index|
        data << s_res.merge(youtube_response[index])
      end
      data
    end
end
