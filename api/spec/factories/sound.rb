# frozen_string_literal: true

FactoryBot.define do
  factory :sound do
    association :search
    isrc { 'JPU901700684' }
    thumbnail_url { 'https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/5a/6f/de/5a6fdeff-ba89-e6c4-dd0f-982481264c46/jacket_KSXX01381B00Z_550.jpg/300x300bb.jpeg' }
    title { '荒野を歩け' }
    artist { 'ASIAN KUNG-FU GENERATION' }
    spotify_url { 'https://open.spotify.com/track/52q1x282D5DvSVNxJZHQPB' }
    apple_music_url { 'https://music.apple.com/jp/album/%E8%8D%92%E9%87%8E%E3%82%92%E6%AD%A9%E3%81%91/1536495860?i=1536495861' }
    kkbox_url { 'https://www.kkbox.com/jp/ja/song/uKa00E1MM52Mjf7iMjf7i0XL-index.html' }
  end
end
