import { createStore } from 'vuex';
import { result } from '@/types/result';
import { responseResult } from '@/types/responseResult';
import parseResponseResult from '@/utils/parseResponseResult';
import axios from 'axios';

export interface State {
  keyword: string;
  results: result[];
  isLoading: boolean;
  currentPage: number;
  showError: boolean;
}

export default createStore<State>({
  state: {
    keyword: '',
    results: [],
    isLoading: false,
    currentPage: 1,
    showError: false,
  },

  mutations: {
    setKeyword(state, keyword: string) {
      state.keyword = keyword;
    },
    setResults(state, results: result[]) {
      state.results = results;
    },
    setIsLoading(state, boolean: boolean) {
      state.isLoading = boolean;
    },
    setCurrentPage(state, page: number) {
      state.currentPage = page;
    },
    setShowError(state, boolean: boolean) {
      state.showError = boolean;
    },
  },

  getters: {
    keyword(state) {
      return state.keyword;
    },

    // TODO: マジックナンバーを定数に切り出す
    sortedResults(state) {
      const resultsDup = state.results;
      const sortedResults: result[] = resultsDup.sort((element, otherElement) => {
        if (element.id > otherElement.id) {
          return 1;
        }
        if (element.id < otherElement.id) {
          return -1;
        }
        return 0;
      });
      return sortedResults;
    },

    isLoading(state) {
      return state.isLoading;
    },

    currentPage(state) {
      return state.currentPage;
    },

    showError(state) {
      return state.showError;
    },
  },

  actions: {
    // TODO: 不要な action かもしれないので調査する
    updateResultsAndPage({ commit }, response: responseResult) {
      commit('setResults', parseResponseResult(response.data.results));
      commit('setCurrentPage', response.data.currentPage);
    },
    updateCurrentPage({ commit }, page: number) {
      commit('setCurrentPage', page);
    },
    // TODO: 不要な action かどうかを検討する
    async updateKeyword({ commit }, keyword: string) {
      await commit('setKeyword', keyword);
    },
    async fetchResults({ commit, state }) {
      try {
        await commit('setIsLoading', true);
        const response = await axios.get('api/v1/search', {
          headers: {
            'Content-Type': 'application/json',
            // NOTE: frontend アプリからではなく、ブラウザから直接URLを叩かれたときに検索結果を返したくないため、
            //  独自ヘッダを追加している。
            'X-Requested-By': 'https://sound-links.com',
          },
          // NOTE: data: {} と指定しないと Content-Type ヘッダをリクエストできない
          //   ref: https://github.com/axios/axios/issues/86
          data: {},
          params: {
            keyword: state.keyword,
            page: state.currentPage,
          },
        });
        await commit('setResults', parseResponseResult(response.data.results));
        await commit('setCurrentPage', response.data.currentPage);
        commit('setIsLoading', false);
      } catch (error) {
        await commit('setIsLoading', false);
        await commit('setShowError', true);
      }
    },
  },

  modules: {
  },
});
