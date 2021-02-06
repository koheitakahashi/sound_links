import { InjectionKey } from "vue";
import { createStore, Store } from "vuex";
import { result } from "../types/result";

export interface State {
  keywords: string;
  results: result[];
}

export const key: InjectionKey<Store<State>> = Symbol();

export const store = createStore<State>({
  state() {
    return {
      keywords: "",
      results: [],
    };
  },

  mutations: {
    addKeywords(state, keyword) {
      state.keywords = keyword;
    },
    addResults(state, results) {
      state.results = results;
    },
  },
});
