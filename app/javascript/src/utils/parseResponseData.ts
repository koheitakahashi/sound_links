import { responseData } from "../types/responseData";

export function parseResponseData(responseData: responseData[]) {
  const parsedResponseData = [];

  responseData.forEach((el) => {
    parsedResponseData.push({
      isrc: el.isrc,
      thumbnail: el.thumbnail,
      title: el.title,
      artist: el.artist,
      spotifyUrl: el.spotify_url,
      appleMusicUrl: el.apple_music_url,
      kkboxUrl: el.kkbox_url,
    });
  });

  return parsedResponseData;
}
