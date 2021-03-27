import { InjectionKey } from "vue";
import { createStore, Store } from "vuex";
import { result } from "../types/result";

export interface State {
  keyword: string;
  results: result[];
  isLoading: boolean;
}

export const key: InjectionKey<Store<State>> = Symbol();

export const store = createStore<State>({
  state: {
    keyword: "",
    results: [],
    isLoading: false,
  },

  mutations: {
    setKeyword(state, keyword :string) {
      state.keyword = keyword;
    },
    setResults(state, results :result[]) {
      state.results = results;
    },
    setIsLoading(state, boolean :boolean) {
      state.isLoading = boolean;
    },
  },
});
