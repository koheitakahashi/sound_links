<template>
  <tr>
    <td><img :src="thumbnail()" /></td>
    <td data-test="title">{{ result.title }}</td>
    <td data-test="artist">{{ result.artist }}</td>
    <td data-test="spotify-url">{{ result.spotifyUrl }}</td>
    <td data-test="apple-music-url">{{ result.appleMusicUrl }}</td>
    <td data-test="kkbox-url">{{ result.kkboxUrl }}</td>
    <td>
      <button @click="copyUrlsToClipBoard(result)">この曲をシェアする</button>
      <div v-show="state.isCopiedUrls">
        クリップボードにURLがコピーされました
      </div>
      <div v-show="state.isFailedCopyUrls">URLのコピーが失敗しました</div>
    </td>
  </tr>
</template>

<script lang="ts">
import { defineComponent, reactive, PropType } from "vue";
import { result } from "../types/result";

const TOOLTIP_SHOW_TIME = 3000;

export default defineComponent({
  name: "Result",
  props: {
    result: {
      type: Object as PropType<result>,
      default: () => {},
    },
  },

  setup() {
    const state = reactive({
      isCopiedUrls: false,
      isFailedCopyUrls: false,
    });

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

    function urlsText(result): string {
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

    function thumbnail(): string {
      return this.result.thumbnail;
    }
    return {
      state,
      thumbnail,
      copyUrlsToClipBoard,
    };
  },
});
</script>

<style scoped></style>
