<template>
  <div>
    <label for="form">検索フォーム</label>
    <input
      v-model="state.keywords"
      @keydown.enter="submitSearch(state.keywords)"
      type="search"
      name="keywords"
      id="form"
      placeholder="キーワードを入力してください"
    />
    <button @click="submitSearch(state.keywords)">search</button>
  </div>
</template>

<script lang="ts">
import { defineComponent, reactive } from "vue";
import { useStore } from "vuex";
import { key } from "../store";
import { parseResponseData } from "../utils/parseResponseData";
import axios from "axios";
import { useRouter, useRoute } from "vue-router";

export default defineComponent({
  name: "SearchForm",
  setup() {
    const router = useRouter();
    const route = useRoute();
    const store = useStore(key);

    const state = reactive({
      keywords: "",
    });

    const submitSearch = async (keyword) => {
      try {
        const response = await axios.get("api/search", {
          params: { keywords: keyword },
        });
        store.commit("addKeywords", keyword);
        store.commit("addResults", parseResponseData(response.data));
        await router.push({
          name: "resultsPage",
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
