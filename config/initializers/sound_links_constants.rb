# frozen_string_literal: true

module SoundLinksConstants
  SPOTIFY_API_KEY = Rails.application.credentials.spotify[:client_id]
  SPOTIFY_API_SECRET_KEY = Rails.application.credentials.spotify[:client_secret]
  SPOTIFY_AUTH_URL = "https://accounts.spotify.com/api/token"
  SPOTIFY_SEARCH_URL = "https://api.spotify.com/v1/search?"

  APPLE_MUSIC_API_KEY = Rails.application.credentials.apple_music[:key_id]
  APPLE_MUSIC_API_SECRET_KEY = Rails.application.credentials.apple_music[:private_key]
  APPLE_MUSIC_TEAM_ID = Rails.application.credentials.apple_music[:team_id]
  APPLE_MUSIC_SEARCH_URL = "https://api.music.apple.com/v1/catalog/jp/search?"

  KKBOX_API_KEY = Rails.application.credentials.kkbox[:client_id]
  KKBOX_API_SECRET_KEY =  Rails.application.credentials.kkbox[:client_secret]
  KKBOX_AUTH_URL = "https://account.kkbox.com/oauth2/token"
  KKBOX_SEARCH_URL = "https://api.kkbox.com/v1.1/search?"
end
