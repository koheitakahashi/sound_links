import { sound } from '@/types/responseResult';
import truncateText from './truncateText';

export default function parseResponseResult(responseData: sound[]) :sound[] {
  const parsedResponse: sound[] = [];

  responseData.forEach((data) => {
    parsedResponse.push({
      isrc: data.isrc,
      thumbnailUrl: data.thumbnailUrl,
      title: truncateText(data.title),
      artist: truncateText(data.artist),
      spotifyUrl: data.spotifyUrl,
      appleMusicUrl: data.appleMusicUrl,
      kkboxUrl: data.kkboxUrl,
    });
  });

  return parsedResponse;
}
