import { createStore } from 'vuex';
import { result } from '@/types/result';
import { responseResult } from '@/types/responseResult';
import parseResponseResult from '@/utils/parseResponseResult';

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
    updateResultsAndPage({ commit }, response: responseResult) {
      commit('setResults', parseResponseResult(response.data.results));
      commit('setCurrentPage', response.data.currentPage);
    },
    // TODO: 不要な action かどうかを検討する
    updateCurrentPage({ commit }, page: number) {
      commit('setCurrentPage', page);
    },
    // TODO: 不要な action かどうかを検討する
    updateKeyword({ commit }, keyword: string) {
      commit('setKeyword', keyword);
    },
  },

  modules: {
  },
});
