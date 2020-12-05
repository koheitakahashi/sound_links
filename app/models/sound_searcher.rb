# frozen_string_literal: true

class SoundSearcher
  def search(keyword)
    spotify_results = ExternalService::Spotify.new.search(keyword)
    apple_music_results = ExternalService::AppleMusic.new.search(keyword)
    kkbox_results = ExternalService::Kkbox.new.search(keyword)

    merge_results(spotify_results, apple_music_results, kkbox_results)
  end

  private
    def merge_results(*results)
      sounds = {}
      results.flatten.each do |result|
        if sounds[result[:isrc]]
          sounds[result[:isrc]] = sounds[result[:isrc]].merge(result)
        else
          sounds[result[:isrc]] = result
        end
      end
      format_results(sounds.values)
    end

    def format_results(results)
      result_struct = Struct.new(:isrc, :title, :artist, :spotify_url, :apple_music_url, :kkbox_url, keyword_init: true)
      results.map { |result| result_struct.new(result) }
    end
end
