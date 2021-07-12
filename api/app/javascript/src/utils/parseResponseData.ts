import { sound } from "../types/responseData";
import { truncateText } from "./truncateText";

// TODO: メソッド名を parseResponseSound などに rename
export function parseResponseData(responseData: sound[]) {
  const parsedResponseData = [];

  responseData.forEach((data) => {
    parsedResponseData.push({
      isrc: data.isrc,
      thumbnailUrl: data.thumbnail_url,
      title: truncateText(data.title),
      artist: truncateText(data.artist),
      spotifyUrl: data.spotify_url,
      appleMusicUrl: data.apple_music_url,
      kkboxUrl: data.kkbox_url,
    });
  });

  return parsedResponseData;
}
