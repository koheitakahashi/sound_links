export type responseData = {
  sounds: sound[],
  current_page: number,
}

export type sound = {
  isrc: string;
  thumbnail_url: string;
  title: string;
  artist: string;
  spotify_url: string;
  apple_music_url: string;
  kkbox_url: string;
};
