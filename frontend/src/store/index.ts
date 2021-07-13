import { createStore } from 'vuex';
import { result } from '@/types/result';
import { responseData } from '@/types/responseData';
import parseResponseData from '@/utils/parseResponseData';

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

  actions: {
    updateResultsAndPage({ commit }, response: responseData) {
      commit('setResults', parseResponseData(response.results));
      commit('setCurrentPage', response.currentPage);
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
