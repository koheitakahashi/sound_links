<template>
  <div>
    <div>
      <h1>SearchForm</h1>
      <label for="form">検索フォーム</label>
      <input
        v-model="state.keywords"
        type="search"
        name="keywords"
        id="form"
        placeholder="キーワードを入力してください"
      />
      <button @click="submitSearch">search</button>
    </div>
    <results-list
      v-show="state.results.length !== 0"
      :results="state.results"
    ></results-list>
  </div>
</template>

<script>
import { defineComponent, reactive } from "vue";
import axios from "axios";
import { parseResponseData } from "./utils/parseResponseData";
import resultsList from "./components/resultsList.vue";

export default defineComponent({
  name: "App",
  components: {
    "results-list": resultsList,
  },
  setup() {
    const state = reactive({
      keywords: "",
      results: [],
    });

    async function submitSearch() {
      try {
        const response = await axios.get("api/search", {
          params: { keywords: state.keywords },
        });
        state.results = parseResponseData(response.data);
      } catch (error) {
        // TODO: エラー時の処理を追加
        console.log(`Error! : ${error}`);
      }
    }

    return {
      state,
      submitSearch,
    };
  },
});
</script>

<style scoped></style>
