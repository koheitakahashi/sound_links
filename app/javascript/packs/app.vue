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
            <th></th>
          </tr>
        </thead>
        <tbody v-for="result in state.results" :key="result.isrc">
          <tr>
            <td>{{ result.title }}</td>
            <td>{{ result.artist }}</td>
            <td>{{ result.spotifyUrl }}</td>
            <td>{{ result.appleMusicUrl }}</td>
            <td>{{ result.kkboxUrl }}</td>
            <td>
              <button @click="copyUrlsToClipBoard(result)">
                この曲をシェアする
              </button>
              <div v-show="state.isCopiedUrls">クリップボードにURLがコピーされました</div>
              <div v-show="state.isFailedUrls">URLのコピーが失敗しました</div>
            </td>
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

const TOOLTIP_SHOW_TIME = 3000;

export default defineComponent({
  name: "App",
  setup() {
    const state = reactive({
      keywords: "",
      results: [],
      isCopiedUrls: false,
      isFailedUrls: false,
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

    function copyUrlsToClipBoard(result) {
      navigator.clipboard
        .writeText(urlsText(result))
        .then(() => {
          state.isCopiedUrls = true;
          setTimeout(function () {
            state.isCopiedUrls = false;
          }, TOOLTIP_SHOW_TIME);
        })
        .catch(() => {
          state.isFailedCopyUrls = true;
          setTimeout(function () {
            state.isFailedCopyUrls = false;
          }, TOOLTIP_SHOW_TIME);
        });
    }

    function urlsText(result) {
      let urls = [`${result.title}(${result.artist})`];

      if (result.spotifyUrl) {
        urls.push(`Spotify\n${result.spotifyUrl}`);
      }
      if (result.appleMusicUrl) {
        urls.push(`Apple Music\n${result.appleMusicUrl}`);
      }
      if (result.kkboxUrl) {
        urls.push(`KKBOX\n${result.kkboxUrl}`);
      }

      return urls.join("\n");
    }

    return {
      state,
      submitSearch,
      copyUrlsToClipBoard,
    };
  },
});
</script>

<style scoped></style>
