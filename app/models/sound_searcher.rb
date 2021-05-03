# frozen_string_literal: true

class SoundSearcher
  def self.execute!(keyword)
    new(keyword: keyword).execute!
  end

  def initialize(keyword:)
    @keyword = keyword
  end

  def execute!
    searching = Search.find_by(keyword: keyword)

    return searching.sounds if searching && searching.created_at > Time.current.ago(1.day)

    ActiveRecord::Base.transaction do
      searching.destroy if searching
      new_searching = Search.create!(keyword: keyword)
      create_sounds_associated(searching: new_searching)
      new_searching.sounds
    end
  end

  private
    attr_reader :keyword

    def fetch_results(keyword)
      spotify_results = ExternalService::Spotify.search(keyword).map { |sound| sound.attributes_exclude(:id) }
      apple_music_results = ExternalService::AppleMusic.search(keyword).map { |sound| sound.attributes_exclude(:id) }
      kkbox_results = ExternalService::Kkbox.search(keyword).map { |sound| sound.attributes_exclude(:id) }

      merge_results(spotify_results, apple_music_results, kkbox_results)
    end

    def merge_results(*sounds_hash)
      merged_sound_hash = {}
      sounds_hash.flatten.each do |result|
        isrc_value = result["isrc"]
        if merged_sound_hash[isrc_value]
          merged_sound_hash[isrc_value] = merged_sound(merged_sound_hash[isrc_value], result)
        else
          merged_sound_hash[isrc_value] = result
        end
      end
      merged_sound_hash.values
    end

    def merged_sound(merged_hash, merge_hash)
      merged_hash.merge(merge_hash) { |_key, old_value, new_value| old_value.nil? ? new_value : old_value }
    end

    # TODO: Rails6.1 から searching.sounds.insert_all(sounds) という記法で、関連付けされたbulk_insert が実行できる。
    #       そのため、6.1 にあげた時に以下を書き換える
    def associate_sound_with_searching(searching:, sounds_hashes:)
      sounds_hashes.each do |sound_hash|
        sound_hash["created_at"] = Time.current
        sound_hash["updated_at"] = Time.current
        sound_hash["search_id"] = searching.id
      end
    end

    def create_sounds_associated(searching:)
      sounds = fetch_results(searching.keyword)
      associated_sounds_hash = associate_sound_with_searching(searching: searching, sounds_hashes: sounds)
      Sound.insert_all(associated_sounds_hash)
    end
end
