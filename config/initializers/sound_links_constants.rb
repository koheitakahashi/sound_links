module SoundLinksConstants
  SPOTIFY_API_KEY = Rails.application.credentials.spotify[:client_id]
  SPOTIFY_API_SECRET_KEY = Rails.application.credentials.spotify[:client_secret]

  APPLE_MUSIC_API_KEY = Rails.application.credentials.apple_music[:key_id]
  APPLE_MUSIC_API_SECRET_KEY = Rails.application.credentials.apple_music[:private_key]
  APPLE_MUSIC_TEAM_ID = Rails.application.credentials.apple_music[:team_id]

  KKBOX_API_KEY = Rails.application.credentials.kkbox[:client_id]
  KKBOX_API_SECRET_KEY =  Rails.application.credentials.kkbox[:client_secret]
end
