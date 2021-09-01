import { shallowMount } from '@vue/test-utils';
import indexStore from '@/store/index';
import Results from '../../../src/components/Results.vue';

describe('ResultComponent', () => {
  const store = indexStore;

  describe('検索結果の表示', () => {
    beforeEach(() => {
      store.commit('setKeyword', '');
      store.commit('setResults', []);
      store.commit('setIsLoading', false);
      store.commit('setCurrentPage', 1);
      store.commit('setShowError', false);
    });

    it('props で1件の検索結果が渡された場合、その1件の検索結果が表示される', () => {
      const results = [
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

      const wrapper = shallowMount(Results, {
        props: { results },
        global: {
          plugins: [store],
        },
      });

      expect(wrapper.findAll('[data-test="results-list"]').length).toBe(1);
    });

    it('props で2件の検索結果が渡された場合、その2件の検索結果が表示される', () => {
      const results = [
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
        {
          id: 2,
          isrc: 'JPU901700684',
          thumbnailUrl: 'https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/5a/6f/de/5a6fdeff-ba89-e6c4-dd0f-982481264c46/jacket_KSXX01381B00Z_550.jpg/300x300bb.jpeg',
          title: '荒野を歩け',
          artist: 'ASIAN KUNG-FU GENERATION',
          spotifyUrl: 'https://open.spotify.com/track/52q1x282D5DvSVNxJZHQPB',
          appleMusicUrl: 'https://music.apple.com/jp/album/%E8%8D%92%E9%87%8E%E3%82%92%E6%AD%A9%E3%81%91/1536495860?i=1536495861',
          kkboxUrl: 'https://www.kkbox.com/jp/ja/song/uKa00E1MM52Mjf7iMjf7i0XL-index.html',
        },
      ];

      const wrapper = shallowMount(Results, {
        props: { results },
        global: {
          plugins: [store],
        },
      });
      expect(wrapper.findAll('[data-test="results-list"]').length).toBe(2);
    });
  });

  it('props で検索結果が渡されなかった場合、メッセージが表示される', () => {
    const results: never[] = [];

    const wrapper = shallowMount(Results, {
      props: { results },
      global: {
        plugins: [store],
      },
    });

    expect(wrapper.findAll('[data-test="results-list"]').length).toBe(0);
    expect(wrapper.text()).toMatch('検索結果がありませんでした');
  });
});
