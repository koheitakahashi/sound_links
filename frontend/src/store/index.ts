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
    sortResults(state) {
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
      state.results = sortedResults;
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

  actions: {
    updateResultsAndPage({ commit }, response: responseResult) {
      commit('setResults', parseResponseResult(response.data.results));
      commit('sortResults');
      commit('setCurrentPage', response.data.currentPage);
    },
    updateCurrentPage({ commit }, page: number) {
      commit('setCurrentPage', page);
    },
    updateKeyword({ commit }, keyword: string) {
      commit('setKeyword', keyword);
    },
  },

  modules: {
  },
});
