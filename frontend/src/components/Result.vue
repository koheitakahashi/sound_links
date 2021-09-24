<template>
  <div>
    <img :src="result.thumbnailUrl"
         alt="検索結果の曲のイメージ画像"
         class="result-item__image"
         data-test="thumbnail"
    />
  </div>
  <div class="result-item-section">
    <div class="result-item-section__explain">
      <p class="result-item-section-explain__title" data-test="title">
        {{ truncatedTitle }}
      </p>
      <p class="result-item-section-explain__artist-name" data-test="artist">
        {{ truncatedArtist }}
      </p>
    </div>
    <div class="result-item-section__actions">
      <div class="result-item-section__copy-actions">
        <button
          @click="copyUrlsToClipBoard(result)"
          class="result-item-section__button"
          data-test="url-copy-button"
        >
          <img src="../../public/img/icons/clip-board-icon.svg"
               alt="クリップボードのアイコン"
               class="result-item-section-button__icon"
          >
          <p class="result-item-section-button__text">URLをコピーする</p>
        </button>
        <span v-show="state.isCopiedUrls" class="tooltip__copied--notice"
              data-test="url-copy-notice"
        >コピーしました</span
        >
      </div>
      <div class="result-item-section__images">
        <a :href="result.appleMusicUrl">
          <img
            src="../../public/img/icons/apple-music-icon.svg"
            alt="AppleMusicのアイコン"
            v-show="result.appleMusicUrl"
            class="result-item-section__icon"
            data-test="apple-music-icon"
          />
        </a>
        <a :href="result.spotifyUrl">
          <img
            src="../../public/img/icons/spotify-icon.svg"
            alt="Spotifyのアイコン"
            v-show="result.spotifyUrl"
            class="result-item-section__icon"
            data-test="spotify-icon"
          />
        </a>
        <a :href="result.kkboxUrl">
          <img
            src="../../public/img/icons/kkbox-icon.svg"
            alt="KKBOXのアイコン"
            v-show="result.kkboxUrl"
            class="result-item-section__icon"
            data-test="kkbox-icon"
          />
        </a>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import {
  defineComponent,
  reactive,
  computed,
  PropType,
} from 'vue';
import { result } from '@/types/result';
import truncateText from '@/utils/truncateText';

const TOOLTIP_SHOW_TIME = 3000;

export default defineComponent({
  name: 'Result',
  props: {
    result: {
      type: Object as PropType<result>,
    },
  },

  setup(props) {
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

    const truncatedTitle = computed(() => {
      if (typeof props.result === 'object') {
        return truncateText(props.result.title);
      }
      return '';
    });

    const truncatedArtist = computed(() => {
      if (typeof props.result === 'object') {
        return truncateText(props.result.artist);
      }
      return '';
    });

    return {
      state,
      truncatedTitle,
      truncatedArtist,
      copyUrlsToClipBoard,
    };
  },
});
</script>

<style scoped></style>
