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
    <div v-show="state.results.length !== 0">
      <table>
        <thead>
          <tr>
            <th>楽曲名</th>
            <th>アーティスト名</th>
            <th>Spotify</th>
            <th>Apple Music</th>
            <th>KKBOX</th>
          </tr>
        </thead>
        <tbody v-for="result in state.results">
          <tr>
            <td>{{ result.title }}</td>
            <td>{{ result.artist}}</td>
            <td>{{ result.spotifyUrl }} </td>
            <td>{{ result.appleMusicUrl }}</td>
            <td>{{ result.kkboxUrl }}</td>
          </tr>
        </tbody>
      </table>
    </div>
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
