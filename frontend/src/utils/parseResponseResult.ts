import { sound } from '@/types/sound';
import truncateText from '@/utils/truncateText';

export default function parseResponseResult(response: sound[]) :sound[] {
  const parsedResponse: sound[] = [];

  response.forEach((element) => {
    parsedResponse.push({
      id: element.id,
      isrc: element.isrc,
      thumbnailUrl: element.thumbnailUrl,
      title: truncateText(element.title),
      artist: truncateText(element.artist),
      spotifyUrl: element.spotifyUrl,
      appleMusicUrl: element.appleMusicUrl,
      kkboxUrl: element.kkboxUrl,
    });
  });

  return parsedResponse;
}
