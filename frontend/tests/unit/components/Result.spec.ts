import { render, fireEvent } from '@testing-library/vue';
import Result from '../../../src/components/Result.vue';

describe('ResultComponent', () => {
  const result = {
    id: 1,
    isrc: 'JPKS00400641',
    thumbnailUrl: 'https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/5a/6f/de/5a6fdeff-ba89-e6c4-dd0f-982481264c46/jacket_KSXX01381B00Z_550.jpg/300x300bb.jpeg',
    title: 'リライト',
    artist: 'ASIAN KUNG-FU GENERATION',
    spotifyUrl: 'https://open.spotify.com/track/52q1x282D5DvSVNxJZHQPB',
    appleMusicUrl: 'https://music.apple.com/jp/album/%E8%8D%92%E9%87%8E%E3%82%92%E6%AD%A9%E3%81%91/1536495860?i=1536495861',
    kkboxUrl: 'https://www.kkbox.com/jp/ja/song/uKa00E1MM52Mjf7iMjf7i0XL-index.html',
  };

  describe('検索結果の表示', () => {
    it('検索結果が1件、props で渡された場合場合、その検索結果が表示される', () => {
      const { getByText } = render(Result, {
        props: { result },
      });
      // const wrapper = render(Result, {
      //   props: { result },
      //   // NOTE: テスト実行時に以下のエラーが発生していた。
      //   //   TypeScript diagnostics
      //   //   (customize using `[jest-config].globals.ts-jest.diagnostics` option):
      //   //   そのため、以下を参考に MountingOptions を設定した。
      //   //   参考: https://github.com/vuejs/vue-test-utils-next/issues/194#issuecomment-749541682
      //   // eslint-disable-next-line @typescript-eslint/ban-types
      // });

      getByText('リライト');

      // expect(getByText('.results-item__image').text()).toBe('https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/5a/6f/de/5a6fdeff-ba89-e6c4-dd0f-982481264c46/jacket_KSXX01381B00Z_550.jpg/300x300bb.jpeg');
    });
  });

  describe('楽曲の URL コピー機能', () => {
    it('その楽曲に Spotify・AppleMusic・KKBOX の3つの URL がある場合、「この曲をシェアする」ボタンをクリックすると、3つの URL がクリップボードにコピーされる', () => {

    });

    it('その楽曲に Spotify の1つの URL がある場合、「この曲をシェアする」ボタンをクリックすると、1つの URL がクリップボードにコピーされる', () => {

    });
  });
});
