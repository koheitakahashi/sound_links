# frozen_string_literal: true

class SoundSearcher
  EXPIRATION_TIME_FOR_VALID_KEYWORD = 1.day
  MAX_PER_PAGE = 10
  DEFAULT_PAGE_NUMBER = 1
  DEFAULT_OFFSET_NUMBER = 0

  def self.execute!(keyword:, page: DEFAULT_PAGE_NUMBER)
    new(keyword: keyword, page: page).execute!
  end

  def initialize(keyword:, page: DEFAULT_PAGE_NUMBER)
    @keyword = keyword
    @page = page
  end

  def execute!
    searching = Search.find_by(keyword: keyword)

    if searching && searching.created_at > Time.current.ago(EXPIRATION_TIME_FOR_VALID_KEYWORD)
      return sounds_in_page_with(searching: searching)
    end

    destroy_searching_and_create_fetched_sound(searching: searching)
  end

  private
    attr_reader :keyword, :page

    def sounds_in_page_with(searching:)
      sounds_in_page = searching.sounds.page(page)

      # TODO: 以下の条件だと、検索結果が10件未満の場合は外部APIにリクエストを投げてしまうので修正する
      if sounds_in_page.count >= MAX_PER_PAGE
        sounds_in_page
      else
        create_fetched_next_sounds(searching: searching, offset: offset_number)
      end
    end

    def destroy_searching_and_create_fetched_sound(searching:)
      ActiveRecord::Base.transaction do
        searching.destroy if searching
        new_searching = Search.create!(keyword: keyword)
        create_sounds_associated(searching: new_searching)
        new_searching.sounds.page(page)
      end
    end

    def create_fetched_next_sounds(searching:, offset: offset_number)
      create_sounds_associated(searching: searching, offset: offset)
      searching.sounds.page(page)
    end

    def create_sounds_associated(searching:, offset: offset_number)
      sounds = fetch_results(keyword: searching.keyword, offset: offset)
      return if sounds.empty?

      associated_sounds_hash = associate_sound_with_searching(searching: searching, sounds_hashes: sounds)
      Sound.insert_all(associated_sounds_hash)
    end

    # TODO: Rails6.1 から searching.sounds.insert_all(sounds) という記法で、関連付けされたbulk_insert が実行できる。
    #       そのため、6.1 にあげた時に以下を書き換える
    def associate_sound_with_searching(searching:, sounds_hashes:)
      sounds_hashes.each do |sound_hash|
        sound_hash['created_at'] = Time.current
        sound_hash['updated_at'] = Time.current
        sound_hash['search_id'] = searching.id
      end
    end

    def fetch_results(keyword:, offset: offset_number)
      spotify_results = ExternalService::Spotify.search(keyword: keyword, offset: offset).map { |sound| sound.attributes_exclude(:id) }
      apple_music_results = ExternalService::AppleMusic.search(keyword: keyword, offset: offset).map { |sound| sound.attributes_exclude(:id) }
      kkbox_results = ExternalService::Kkbox.search(keyword: keyword, offset: offset).map { |sound| sound.attributes_exclude(:id) }

      merge_results(spotify_results, apple_music_results, kkbox_results)
    end

    def merge_results(*sounds_hash)
      merged_sound_hash = {}
      sounds_hash.flatten.each do |result|
        isrc_value = result['isrc']
        if merged_sound_hash[isrc_value]
          merged_sound_hash[isrc_value] = merged_sound(merged_sound_hash[isrc_value], result)
        else
          merged_sound_hash[isrc_value] = result
        end
      end
      # NOTE: frontend には null を返さない方針のため、ここで nil の値は空文字にしている
      merged_sound_hash.deep_transform_values { |value| value.to_s }.values
    end

    def merged_sound(merged_hash, merge_hash)
      merged_hash.merge(merge_hash) { |_key, old_value, new_value| old_value.nil? ? new_value : old_value }
    end

    def offset_number
      page <= DEFAULT_PAGE_NUMBER ? DEFAULT_OFFSET_NUMBER : (page - DEFAULT_PAGE_NUMBER) * MAX_PER_PAGE
    end
end
