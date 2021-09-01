import indexStore from '@/store/index';

describe('@/store/index', () => {
  const store = indexStore;

  beforeEach(() => {
    store.commit('setKeyword', '');
    store.commit('setResults', []);
    store.commit('setIsLoading', false);
    store.commit('setCurrentPage', 1);
    store.commit('setShowError', false);
  });

  describe('mutations', () => {
    describe('setKeyword', () => {
      test('文字列を渡した場合、store.keyword がその文字列に更新される', () => {
        expect(store.state.keyword).toBe('');
        store.commit('setKeyword', 'リライト');
        expect(store.state.keyword).toBe('リライト');
      });
    });

    describe('setResults', () => {
      test('result[] を渡した場合、store.results がその値に更新される', () => {
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
        expect(store.state.results).toStrictEqual([]);
        store.commit('setResults', results);
        expect(store.state.results.length).toBe(1);
        expect(store.state.results[0]).toStrictEqual(results[0]);
      });
    });

    describe('setIsLoading', () => {
      test('true を渡した場合、store.isLoading が true に更新される', () => {
        expect(store.state.isLoading).toBe(false);
        store.commit('setIsLoading', true);
        expect(store.state.isLoading).toBe(true);
      });
    });

    describe('setShowError', () => {
      test('true を渡した場合、setShowError が true に更新される', () => {
        expect(store.state.showError).toBe(false);
        store.commit('setShowError', true);
        expect(store.state.showError).toBe(true);
      });
    });
  });

  describe('getters', () => {
    describe('keyword', () => {
      test('store.keyword が更新された場合、更新後の keyword を返す', () => {
        expect(store.getters.keyword).toBe('');
        store.commit('setKeyword', 'リライト');
        expect(store.getters.keyword).toBe('リライト');
      });
    });

    describe('sortedResults', () => {
      const results = [
        {
          id: 2,
          isrc: 'JPKS00400641',
          thumbnailUrl: 'https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/5a/6f/de/5a6fdeff-ba89-e6c4-dd0f-982481264c46/jacket_KSXX01381B00Z_550.jpg/300x300bb.jpeg',
          title: 'リライト',
          artist: 'ASIAN KUNG-FU GENERATION',
          spotifyUrl: 'https://open.spotify.com/track/52q1x282D5DvSVNxJZHQPB',
          appleMusicUrl: 'https://music.apple.com/jp/album/%E8%8D%92%E9%87%8E%E3%82%92%E6%AD%A9%E3%81%91/1536495860?i=1536495861',
          kkboxUrl: 'https://www.kkbox.com/jp/ja/song/uKa00E1MM52Mjf7iMjf7i0XL-index.html',
        },
        {
          id: 1,
          isrc: 'JPU901700684',
          thumbnailUrl: 'https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/5a/6f/de/5a6fdeff-ba89-e6c4-dd0f-982481264c46/jacket_KSXX01381B00Z_550.jpg/300x300bb.jpeg',
          title: '荒野を歩け',
          artist: 'ASIAN KUNG-FU GENERATION',
          spotifyUrl: '',
          appleMusicUrl: '',
          kkboxUrl: '',
        },
        {
          id: 3,
          isrc: 'JPU901603312',
          thumbnailUrl: 'https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/5a/6f/de/5a6fdeff-ba89-e6c4-dd0f-982481264c46/jacket_KSXX01381B00Z_550.jpg/300x300bb.jpeg',
          title: '遥か彼方',
          artist: 'ASIAN KUNG-FU GENERATION',
          spotifyUrl: '',
          appleMusicUrl: '',
          kkboxUrl: '',
        },
      ];
      test('storeに保存されている results を id の昇順でソートした結果を返す', () => {
        expect(store.getters.sortedResults).toStrictEqual([]);
        store.commit('setResults', results);
        const actual = store.getters.sortedResults.map((result: { id: number; }) => result.id);
        expect(actual).toStrictEqual([1, 2, 3]);
      });
    });

    describe('isLoading', () => {
      test('store.isLoadingが更新された場合、更新後の isLoading を返す', () => {
        expect(store.getters.isLoading).toBe(false);
        store.commit('setIsLoading', true);
        expect(store.getters.isLoading).toBe(true);
      });
    });

    describe('showError', () => {
      test('store.showErrorが更新された場合、更新後の showError を返す', () => {
        expect(store.state.showError).toBe(false);
        store.commit('setShowError', true);
        expect(store.state.showError).toBe(true);
      });
    });
  });

  describe('actions', () => {
    describe('updateResultsAndPage', () => {
      const response = {
        data: {
          results: [
            {
              id: 1070,
              isrc: 'JPKS00400641',
              thumbnailUrl: 'https://i.scdn.co/image/ab67616d00001e0242b08c3ee667cbba84372739',
              title: 'リライト',
              artist: 'ASIAN KUNG-FU GENERATION',
              spotifyUrl: 'https://open.spotify.com/track/3txqYlzoDZGLoW8MGll9tQ',
              appleMusicUrl: 'https://music.apple.com/jp/album/%E3%83%AA%E3%83%A9%E3%82%A4%E3%83%88/1536394883?i=1536394888',
              kkboxUrl: 'https://www.kkbox.com/jp/ja/song/FcqGD-90I.n6HlVI7lVI70P4-index.html',
            },
          ],
          currentPage: 2,
        },
      };
      test('空ではない response を渡した場合、store.result と store.currentPage が response の値に更新される', async () => {
        expect(store.state.results).toStrictEqual([]);
        expect(store.state.currentPage).toBe(1);

        await store.dispatch('updateResultsAndPage', response);
        expect(store.state.results.length).toBe(1);
        expect(store.state.currentPage).toBe(2);
      });
    });
  });
});
