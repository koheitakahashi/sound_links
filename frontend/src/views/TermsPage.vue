<template>
  <header class="header">
    <h1><router-link to="/" class="header__title">Sound Links</router-link></h1>
    <search-form class="search-form-wrapper__results"></search-form>
  </header>
  <main class="main-wrapper__terms">
    <terms></terms>
  </main>
  <footer-component class="footer-wrapper__terms"></footer-component>
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
