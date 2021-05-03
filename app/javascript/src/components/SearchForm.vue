<template>
  <div class="search-form">
    <label for="form"></label>
    <input
      v-model="state.keyword"
      @keydown.enter="submitSearch(state.keyword)"
      type="search"
      name="keyword"
      id="form"
      data-test="search-form"
      placeholder="楽曲名を入力してください"
      class="search-form__input"
    />
    <button
      @click="submitSearch(state.keyword)"
      data-test="search-submit-button"
      class="search-form__button"
    >
      <search-icon size="lg" class="search-form-button__icon"></search-icon>
    </button>
  </div>
</template>

<script lang="ts">
import { defineComponent, reactive } from "vue";
import { useStore } from "vuex";
import { parseResponseData } from "../utils/parseResponseData";
import { useRouter, useRoute } from "vue-router";
import axios from "axios";
import { key } from "../store";
import SearchIcon from "./SearchIcon";

export default defineComponent({
  name: "SearchForm",
  components: {
    SearchIcon,
  },
  setup() {
    const router = useRouter();
    const route = useRoute();
    const store = useStore(key);

    const state = reactive({
      keyword: "",
    });

    const submitSearch = async (keyword) => {
      if (keyword === "") {
        return;
      }

      try {
        await router.push({
          name: "ResultsPage",
          query: { keyword: keyword },
        });
        store.commit("setIsLoading", true);
        const response = await axios.get("search.json", {
          params: { keyword: keyword },
        });
        store.commit("setKeyword", keyword);
        store.commit("setResults", parseResponseData(response.data));
        store.commit("setIsLoading", false);
      } catch (error) {
        store.commit("setIsLoading", false);
        console.log(`Error! : ${error}`);
      }
    };

    if (route.query.keyword) {
      // NOTE: route.query.keywords をそのまま state.keywords にいれると、route.query.keywordsが String 以外にもなり得るため代入できない
      let params = new URLSearchParams(window.location.search);
      state.keyword = params.get("keyword");
      submitSearch(route.query.keyword);
    }

    return {
      state,
      submitSearch,
    };
  },
});
</script>

<style scoped></style>
