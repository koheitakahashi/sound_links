import { result } from '@/types/result';

export default function urlsText(resultItem: result): string {
  const urls = [`${resultItem.title}(${resultItem.artist})`];

  if (resultItem.spotifyUrl) {
    urls.push(`Spotify\n${resultItem.spotifyUrl}`);
  }
  if (resultItem.appleMusicUrl) {
    urls.push(`Apple Music\n${resultItem.appleMusicUrl}`);
  }
  if (resultItem.kkboxUrl) {
    urls.push(`KKBOX\n${resultItem.kkboxUrl}`);
  }
  urls.push('\nCreated by https://sound-links.com');

  return urls.join('\n');
}
