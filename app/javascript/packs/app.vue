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
    <h2>results</h2>
    <div v-show="state.results.length !== 0">{{ state.results }}</div>
  </div>
</template>

<script>
import { defineComponent, reactive } from "vue";
import axios from "axios";
import { parseResponseData } from "./utils/parseResponseData";

export default defineComponent({
  name: "App",
  setup() {
    const state = reactive({
      keywords: '',
      results: []
    })

    async function submitSearch() {
      try {
        const response = await axios.get("api/search", { params: { keywords: state.keywords }})
        state.results = parseResponseData(response.data)
      } catch(error) {
        console.log(`Error! : ${error}`)
      }
    }

    return {
      state,
      submitSearch,
    }
  },
});
</script>

<style scoped></style>
