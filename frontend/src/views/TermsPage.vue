<template>
  <div>
    <header class="header">
      <router-link to="/">
        <img src="/img/logo.svg" alt="SoundLinksのロゴ" class="header__logo">
      </router-link>
      <search-form
        class="search-form-wrapper__results"
        parent-component="ResultsPage"
      ></search-form>
    </header>
    <main class="main-wrapper__terms">
      <terms></terms>
    </main>
    <footer-component class="footer-wrapper__terms"></footer-component>
  </div>
</template>

<script lang="ts">
import SearchForm from '../components/SearchForm.vue';
import Terms from '../components/Terms.vue';
import FooterComponent from '../components/Footer.vue';

export default {
  name: 'TermsPage',
  components: {
    SearchForm,
    Terms,
    FooterComponent,
  },
};
</script>

<style scoped></style>
