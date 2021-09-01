import { shallowMount } from '@vue/test-utils';
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
    it('props で検索結果が渡された場合、その検索結果が表示される', () => {
      const wrapper = shallowMount(Result, {
        props: { result },
      });

      expect(wrapper.find('[data-test="thumbnail"]').exists()).toBe(true);
      expect(wrapper.find('[data-test="title"]').text()).toBe('リライト');
      expect(wrapper.find('[data-test="artist"]').text()).toBe('ASIAN KUNG-FU GENERATION');
      expect(wrapper.find('[data-test="apple-music-icon"]').isVisible()).toBe(true);
      expect(wrapper.find('[data-test="spotify-icon"]').isVisible()).toBe(true);
      expect(wrapper.find('[data-test="kkbox-icon"]').isVisible()).toBe(true);
    });
  });

  describe('楽曲の URL コピー機能', () => {
    // NOTE: mock方法は以下を参考にした
    //   https://stackoverflow.com/questions/62351935/how-to-mock-navigator-clipboard-writetext-in-jest
    Object.defineProperty(navigator, 'clipboard', {
      value: {
        writeText: () => Promise.resolve(),
      },
    });

    it('「この曲をシェアする」ボタンをクリックした場合、「この曲をシェアする」ボタンを押すとメッセージが表示される', async () => {
      const wrapper = shallowMount(Result, {
        props: { result },
      });

      expect(wrapper.find('[data-test="url-copy-notice"]').isVisible()).toBe(false);
      await wrapper.find('[data-test=url-copy-button]').trigger('click');

      expect(wrapper.find('[data-test="url-copy-notice"]').isVisible()).toBe(true);
    });
  });
});
