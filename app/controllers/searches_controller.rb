# frozen_string_literal: true

class SearchesController < ApplicationController
  def index
  end

  def show
    # TODO 検索フォームが空の時にエラーを表示するなどの処理を加えること
    query = params[:query]
    return unless query.present?

    spotify = SpotifyRepository.new
    sounds = spotify.search(query)
    @results = formatted(sounds)
  end

  private
    def formatted(response)
      JSON.parse(response.body)["tracks"]["items"].map do |item|
        {
          name: item["name"],
          artist_name: item["artists"][0]["name"],
          url: item["external_urls"]["spotify"]
        }
      end
    end
end
