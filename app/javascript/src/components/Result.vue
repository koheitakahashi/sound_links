<template>
  <div class="results-item">
    <img :src="thumbnail()" alt="" class="results-item__image" />
    <div class="results-item-section">
      <div class="results-item-section__explain">
        <p class="results-item-section-explain__title" data-test="title">
          {{ result.title }}
        </p>
        <p class="results-item-section-explain__artist-name" data-test="artist">
          {{ result.artist }}
        </p>
      </div>
      <div class="results-item-section__actions">
        <div class="results-item-section__copy-actions">
          <button
            @click="copyUrlsToClipBoard(result)"
            class="results-item-section__button"
            data-test="url-copy-button"
          >
            この曲をシェアする
          </button>
          <span v-show="state.isCopiedUrls" class="tooltip__copied--notice"
            >楽曲のURLがコピーされました</span
          >
        </div>
        <div class="results-item-section__images">
          <a :href="result.spotifyUrl" data-test="spotify-url">
            <img
              src="../../images/spotify_icon.svg"
              alt=""
              v-show="result.spotifyUrl"
              class="results-item-section__icon"
            />
          </a>
          <a :href="result.appleMusicUrl" data-test="apple-music-url">
            <img
              src="../../images/apple_music_icon.svg"
              alt=""
              v-show="result.appleMusicUrl"
              class="results-item-section__icon"
            />
          </a>
          <a :href="result.kkboxUrl" data-test="kkbox-url">
            <img
              src="../../images/kkbox_icon.svg"
              alt=""
              v-show="result.kkboxUrl"
              class="results-item-section__icon"
            />
          </a>
        </div>
      </div>
    </div>
  </div>
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
    });

    function copyUrlsToClipBoard(result): void {
      navigator.clipboard.writeText(urlsText(result)).then(() => {
        state.isCopiedUrls = true;
        setTimeout(function () {
          state.isCopiedUrls = false;
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
      debugger
      return this.result.thumbnailUrl;
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
