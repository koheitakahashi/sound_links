import { sound } from '@/types/responseData';
import truncateText from './truncateText';

// TODO: メソッド名を parseResponseSound などに rename
// TODO: API 側でレスポンスを送るときに camel_case にして送る
export default function parseResponseData(responseData: sound[]) :sound[] {
  const parsedResponseData: sound[] = [];

  responseData.forEach((data) => {
    parsedResponseData.push({
      isrc: data.isrc,
      thumbnailUrl: data.thumbnailUrl,
      title: truncateText(data.title),
      artist: truncateText(data.artist),
      spotifyUrl: data.spotifyUrl,
      appleMusicUrl: data.appleMusicUrl,
      kkboxUrl: data.kkboxUrl,
    });
  });

  return parsedResponseData;
}
