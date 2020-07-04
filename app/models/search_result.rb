# frozen_string_literal: true

class SearchResult
  attr_reader :isrc, :title, :artist, :spotify_url, :apple_music_url, :youtube_url, :youtube_license

  def initialize(isrc: nil, title: nil, artist: nil, spotify_url: nil, apple_music_url: nil, youtube_url: nil, youtube_license: nil)
      @isrc = isrc
      @title = title
      @artist = artist
      @spotify_url = spotify_url
      @apple_music_url = apple_music_url
      @youtube_url = youtube_url
      @youtube_license = youtube_license
  end

  def merge(another)
    SearchResult.new(
      isrc: self.isrc.nil? ? another.isrc : self.isrc,
      title: self.title.nil? ? another.title : self.title,
      artist: self.artist.nil? ? another.artist : self.artist,
      spotify_url: self.spotify_url.nil? ? another.spotify_url : self.spotify_url,
      apple_music_url: self.apple_music_url.nil? ? another.apple_music_url: self.apple_music_url,
      youtube_url: self.youtube_url.nil? ? another.youtube_url : self.youtube_url,
      youtube_license: self.youtube_license.nil? ? another.youtube_license : self.youtube_license
    )
  end
end
