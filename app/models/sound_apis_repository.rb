# frozen_string_literal: true

class SoundApisRepository
  def search(keyword)
    spotify = SpotifyApiRepository.new
    apple_music = AppleMusicApiRepository.new
    youtube = YoutubeApiRepository.new

    spotify_search_results = spotify.search(keyword)
    apple_music_search_results = apple_music.search(keyword)
    youtube_search_results = youtube.search(keyword)

    merge_search_results(spotify_search_results, apple_music_search_results, youtube_search_results)
  end

  private
    def sound_format
      {
        isrc: nil,
        title: nil,
        artist: nil,
        spotify_url: nil,
        apple_music_url: nil,
        youtube_url: nil,
        youtube_license: nil
      }
    end

    def merge_search_results(spotify_search_results, apple_music_search_results, youtube_search_results)
      formatted_spotify_results = format_results(spotify_search_results)
      formatted_apple_music_results = format_results(apple_music_search_results)
      formatted_youtube_results = youtube_search_results.map { |item| sound_format.merge(item) }

      merged_spotify_apple_music_results = merge_sounds_by_condition(formatted_spotify_results, formatted_apple_music_results, check_isrc)
      merge_sounds_by_condition(merged_spotify_apple_music_results, formatted_youtube_results, check_include_title_artist)
    end

    def check_isrc
      Proc.new { |response, item| response[:isrc] === item[:isrc] }
    end

    def check_include_title_artist
      Proc.new { |response, item| response[:title].include?(item[:title]) && response[:artist].include?(item[:artist]) }
    end

    def format_results(search_results)
      search_results.map { |item| sound_format.merge(item) }.uniq  { |item| item[:isrc] }
    end

    def merge_results(results_1, results_2)
      results_1.merge(results_2) { |key, results_1_val, results_2_val| results_1_val.nil? ? results_2_val : results_1_val }
    end

    def add_rested_results(results, container)
      results.each { |item| container << item }
    end

    def merge_sounds_by_condition(formatted_results_1, formatted_results_2, find_condition)
      sounds_info = []

      formatted_results_1.each do |item|
        if sound_data = formatted_results_2.find { |response| find_condition.call(response, item) }
          sounds_info << item.merge(sound_data) { |key, item_val, sound_data_val| item_val.nil? ? sound_data_val : item_val }
          formatted_results_2.delete(sound_data)
        else
          sounds_info << item
        end
      end

      add_rested_results(formatted_results_2, sounds_info)
      sounds_info
    end
end
