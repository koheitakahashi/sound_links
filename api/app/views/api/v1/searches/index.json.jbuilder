json.key_format! camelize: :lower
json.deep_format_keys!

json.data do
  json.results do
    # NOTE: json.array! @results では、配列の中の Hash のキーが camelCase に変換されなかった
    # NOTE: Sound の attribute が増えたら、ここの記述を変更する
    json.array! @results do |result|
      json.id result.id
      json.isrc result.isrc
      json.thumbnail_url result.thumbnail_url
      json.title result.title
      json.artist result.artist
      json.spotify_url result.spotify_url
      json.apple_music_url result.apple_music_url
      json.kkbox_url result.kkbox_url
    end
  end
  json.set! :current_page, @results.current_page
end
