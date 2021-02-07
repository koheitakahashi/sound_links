<template>
  <header class="header">
    <!--    TODO: 後で差し替える-->
    <img src="https://placehold.jp/150x150.png" class="header__logo" />
    <h1 class="header__title">Sound Links</h1>
  </header>

  <div class="container">
    <main class="welcome-page">
      <div class="welcome-section__explain">
        <h2 class="welcome-section-explain__header">
          音楽を見つけてシェアする
        </h2>
        <div class="welcome-section-explain__inner-text">
          <p>
            複数の音楽プラットフォームから、好きな楽曲を検索することができます。
          </p>
          <p>
            検索した楽曲のリンクを、ワンクリックでまとめてコピーすることができます。
          </p>
        </div>
      </div>
      <search-form class="welcome-section__search-form"></search-form>
      <div class="welcome-section__external-service">
        <h3 class="welcome-section-external-service__header">
          以下のサービスに対応しています
        </h3>
        <div class="welcome-section-external-service__sections">
          <div class="welcome-small-section">
            <a href="https://www.apple.com/jp/apple-music">
              <img
                src="../../images/apple_music_icon.svg"
                alt=""
                class="welcome-small-section__image"
              />
            </a>
            <a
              href="https://www.apple.com/jp/apple-music"
              class="welcome-small-section__title"
            >
              Apple Music
            </a>
          </div>
          <div class="welcome-small-section">
            <a href="https://www.spotify.com/us">
              <img
                src="../../images/spotify_icon.svg"
                alt=""
                class="welcome-small-section__image"
              />
            </a>
            <a
              href="https://www.spotify.com/us/"
              class="welcome-small-section__title"
              >Spotify</a
            >
          </div>
          <div class="welcome-small-section">
            <a href="https://www.kkbox.com/jp/ja/">
              <img
                src="../../images/kkbox-icon.svg"
                alt=""
                class="welcome-small-section__image"
              />
            </a>
            <a
              href="https://www.kkbox.com/jp/ja/"
              class="welcome-small-section__title"
            >
              KKBOX
            </a>
          </div>
        </div>
      </div>
    </main>
  </div>

  <footer-component></footer-component>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import SearchForm from "../components/SearchForm.vue";
import FooterComponent from "../components/Footer.vue";

export default defineComponent({
  name: "TopPage",
  components: {
    SearchForm,
    FooterComponent,
  },
});
</script>

<style scoped></style>
