<template>
  <header class="header">
    <!-- TODO: 後で差し替える-->
    <img src="https://placehold.jp/150x150.png" alt="" class="header__logo" />
    <h1><router-link to="/" class="header__title">Sound Links</router-link></h1>
    <search-form class="search-form-wrapper__results"></search-form>
  </header>
  <main class="main-wrapper__terms">
    <terms></terms>
  </main>
  <footer-component class="footer-wrapper__terms"></footer-component>
</template>

<script lang="ts">

import SearchForm from "../components/SearchForm"
import Terms from "../components/Terms"
import FooterComponent from "../components/Footer"

export default {
  name: "TermsPage.vue",
  components: {
    SearchForm,
    Terms,
    FooterComponent
  }
}
</script>

<style scoped>

</style>
