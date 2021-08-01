// TODO: 削除する予定のテスト

import { sound } from '@/types/sound';
import parseResponseResult from '@/utils/parseResponseResult';

describe('parseResponseResult', () => {
  it('全てのフィールドが入った response が渡された場合', () => {
    const response :sound[] = [
      {
        id: 1,
        isrc: 'JPKS00400641',
        thumbnailUrl: 'https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/5a/6f/de/5a6fdeff-ba89-e6c4-dd0f-982481264c46/jacket_KSXX01381B00Z_550.jpg/300x300bb.jpeg',
        title: 'リライト',
        artist: 'ASIAN KUNG-FU GENERATION',
        spotifyUrl: 'https://open.spotify.com/track/52q1x282D5DvSVNxJZHQPB',
        appleMusicUrl: 'https://music.apple.com/jp/album/%E8%8D%92%E9%87%8E%E3%82%92%E6%AD%A9%E3%81%91/1536495860?i=1536495861',
        kkboxUrl: 'https://www.kkbox.com/jp/ja/song/uKa00E1MM52Mjf7iMjf7i0XL-index.html',
      },
    ];

    const expected :sound[] = [
      {
        id: 1,
        isrc: 'JPKS00400641',
        thumbnailUrl: 'https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/5a/6f/de/5a6fdeff-ba89-e6c4-dd0f-982481264c46/jacket_KSXX01381B00Z_550.jpg/300x300bb.jpeg',
        title: 'リライト',
        artist: 'ASIAN KUNG-FU GENERATION',
        spotifyUrl: 'https://open.spotify.com/track/52q1x282D5DvSVNxJZHQPB',
        appleMusicUrl: 'https://music.apple.com/jp/album/%E8%8D%92%E9%87%8E%E3%82%92%E6%AD%A9%E3%81%91/1536495860?i=1536495861',
        kkboxUrl: 'https://www.kkbox.com/jp/ja/song/uKa00E1MM52Mjf7iMjf7i0XL-index.html',
      },
    ];

    expect(parseResponseResult(response)).toEqual(expected);
  });
});
