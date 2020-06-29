# frozen_string_literal: true

class SoundAPI
  def search(keyword)
    spotify = Spotify.new
    apple_music = AppleMusic.new
    youtube = Youtube.new

    spotify_results = spotify.search(keyword)
    apple_music_results = apple_music.search(keyword)
    youtube_results = youtube.search(keyword)

    merge_each_results(spotify_results, apple_music_results, youtube_results)
  end

  private
    def merge_each_results(spotify_results, apple_music_results, youtube_results)
      merged_spotify_apple_music_results = merge_results_by_condition(spotify_results, apple_music_results, equal_isrc)
      merge_results_by_condition(merged_spotify_apple_music_results, youtube_results, include_title_artist)
    end

    def equal_isrc
      Proc.new { |item_1, item_2| item_1.isrc === item_2.isrc }
    end

    def include_title_artist
      Proc.new { |item_1, item_2| item_1.title.include?(item_2.title) && item_1.artist.include?(item_2.artist) }
    end

    def merge_results_by_condition(results_1, results_2, find_condition)
      sound_list = []

      results_1.each do |result|
        if sound = results_2.find { |item| find_condition.call(item, result) }
          sound_list << result.merge(sound)
          results_2.delete(sound)
        else
          sound_list << result
        end
      end

      results_2.each { |item| sound_list << item }
      sound_list
    end
end
