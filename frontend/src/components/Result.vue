<template>
  <div class="results-item">
    <img :src="result.thumbnailUrl" alt="" class="results-item__image" />
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
          <a :href="result.appleMusicUrl" data-test="apple-music-url">
            <img
              src="../../public/img/icons/apple-music-icon.svg"
              alt=""
              v-show="result.appleMusicUrl"
              class="results-item-section__icon"
            />
          </a>
          <a :href="result.spotifyUrl" data-test="spotify-url">
            <img
              src="../../public/img/icons/spotify-icon.svg"
              alt=""
              v-show="result.spotifyUrl"
              class="results-item-section__icon"
            />
          </a>
          <a :href="result.kkboxUrl" data-test="kkbox-url">
            <img
              src="../../public/img/icons/kkbox-icon.svg"
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
import { defineComponent, reactive, PropType } from 'vue';
import { result } from '@/types/result';

const TOOLTIP_SHOW_TIME = 3000;

export default defineComponent({
  name: 'Result',
  props: {
    result: {
      type: Object as PropType<result>,
      default() {
        return {};
      },
    },
  },

  setup() {
    const state = reactive({
      isCopiedUrls: false,
    });

    function urlsText(resultItem: result): string {
      const urls = [`${resultItem.title}(${resultItem.artist})`];

      if (resultItem.spotifyUrl) {
        urls.push(`Spotify\n${resultItem.spotifyUrl}`);
      }
      if (resultItem.appleMusicUrl) {
        urls.push(`Apple Music\n${resultItem.appleMusicUrl}`);
      }
      if (resultItem.kkboxUrl) {
        urls.push(`KKBOX\n${resultItem.kkboxUrl}`);
      }

      return urls.join('\n');
    }

    function copyUrlsToClipBoard(resultItem: result): void {
      navigator.clipboard.writeText(urlsText(resultItem)).then(() => {
        state.isCopiedUrls = true;
        setTimeout(() => {
          state.isCopiedUrls = false;
        }, TOOLTIP_SHOW_TIME);
      });
    }

    return {
      state,
      copyUrlsToClipBoard,
    };
  },
});
</script>

<style scoped></style>
