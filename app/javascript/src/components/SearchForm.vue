<template>
  <div class="search-form">
    <label for="form"></label>
    <input
      v-model="state.keywords"
      @keydown.enter="submitSearch(state.keywords)"
      type="search"
      name="keywords"
      id="form"
      data-test="search-form"
      placeholder="楽曲名を入力してください"
      class="search-form__input"
    />
    <button
      @click="submitSearch(state.keywords)"
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
      keywords: "",
    });

    const submitSearch = async (keyword) => {
      if (keyword === "") {
        return;
      }

      try {
        const response = await axios.get("api/search", {
          params: { keywords: keyword },
        });
        store.commit("addKeywords", keyword);
        store.commit("addResults", parseResponseData(response.data));
        await router.push({
          name: "ResultsPage",
          query: { keywords: keyword },
        });
      } catch (error) {
        // TODO: エラー時の処理を追加
        console.log(`Error! : ${error}`);
      }
    };

    if (route.query.keywords) {
      // NOTE: route.query.keywords をそのまま state.keywords にいれると、route.query.keywordsが String 以外にもなり得るため代入できない
      let params = new URLSearchParams(window.location.search);
      state.keywords = params.get("keywords");
      submitSearch(route.query.keywords);
    }

    return {
      state,
      submitSearch,
    };
  },
});
</script>

<style scoped></style>
