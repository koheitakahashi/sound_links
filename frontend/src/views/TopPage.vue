<template>
  <div>
    <header class="header">
      <router-link to="/">
        <img src="/img/logo.svg" alt="SoundLinksのロゴ" class="header__logo">
      </router-link>
    </header>

    <div class="container">
      <main class="welcome-page">
        <div class="welcome-section__explain-top">
          <h2 class="welcome-section-explain__header">
            音楽を見つけてシェアしよう
          </h2>
          <search-form
            class="welcome-section__search-form"
            parent-compont="topPage"
            data-test="top-page-result-form"
          ></search-form>
        </div>
        <div class="welcome-section__explain">
          <div class="welcome-section-explain__usage">
            <div class="welcome-section-explain-usage__text">
              <h2>音楽を探す</h2>
              <p>複数の音楽配信サービスからお好きな音楽を探せます</p>
            </div>
            <img
              src="../../public/img/icons/searching.svg"
              alt="何かを検索している画像"
              class="welcome-section-explain-usage__image"
            />
          </div>
          <div class="welcome-section-explain__usage">
            <div class="welcome-section-explain-usage__text">
              <h2>音楽のURLをコピーする</h2>
              <p>複数の音楽配信サービスの楽曲URLをワンクリックでコピーできます</p>
            </div>
            <img
              src="../../public/img/icons/link.svg"
              alt="URLのリンクを持っている画像"
              class="welcome-section-explain-usage__image"
            />
          </div>
          <div class="welcome-section-explain__usage">
            <div class="welcome-section-explain-usage__text">
              <h2>シェアする</h2>
              <p>コピーした音楽のURLをチャットやメール・SNSなどに貼り付けてシェアできます</p>
            </div>
            <img
              src="../../public/img/icons/chatting.svg"
              alt="スマートフォンでチャットをしている画像"
              class="welcome-section-explain-usage__image"
            />
          </div>
        </div>
        <div class="welcome-section__external-service">
          <div class="welcome-section-external-service__text">
            <h2>対応サービス</h2>
            <p>※APIが外部公開されている音楽配信サービスのみ対応しています。</p>
            <p>※今後他の音楽配信サービスのAPIが公開され次第、対応するサービスを拡大します。</p>
          </div>
          <div class="welcome-section-external-service__sections">
            <div class="welcome-small-section">
              <div class="welcome-small-section__apple-music">
                <a href="https://www.apple.com/jp/apple-music">
                  <img
                    src="../../public/img/icons/apple-music-icon.svg"
                    alt="AppleMusicのロゴ"
                    class="welcome-small-section-image__apple-music"
                  />
                </a>
                <a href="https://www.apple.com/jp/apple-music" class="welcome-small-section__apple-music-title">
                  <h3>Apple Music</h3>
                </a>
              </div>
            </div>
            <div class="welcome-small-section">
              <a href="https://www.spotify.com/us">
                <img
                  src="../../public/img/icons/spotify-logo.svg"
                  alt="Spotifyのロゴ"
                  class="welcome-small-section__image"
                />
              </a>
            </div>
            <div class="welcome-small-section">
              <a href="https://www.kkbox.com/jp/ja/">
                <img
                  src="../../public/img/icons/kkbox-logo.svg"
                  alt="KKBOXのロゴ"
                  class="welcome-small-section__image"
                />
              </a>
            </div>
          </div>
        </div>
      </main>
    </div>

    <footer-component class="footer-wrapper__top-page"></footer-component>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import SearchForm from '../components/SearchForm.vue';
import FooterComponent from '../components/Footer.vue';

export default defineComponent({
  name: 'TopPage',
  components: {
    SearchForm,
    FooterComponent,
  },
});
</script>

<style scoped></style>
