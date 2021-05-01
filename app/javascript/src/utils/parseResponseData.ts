import { responseData } from "../types/responseData";
import { truncateText } from "./truncateText";

export function parseResponseData(responseData: responseData[]) {
  const parsedResponseData = [];

  responseData.forEach((data) => {
    parsedResponseData.push({
      isrc: data.isrc,
      thumbnail: data.thumbnail,
      title: truncateText(data.title),
      artist: truncateText(data.artist),
      spotifyUrl: data.spotify_url,
      appleMusicUrl: data.apple_music_url,
      kkboxUrl: data.kkbox_url,
    });
  });

  return parsedResponseData;
}
