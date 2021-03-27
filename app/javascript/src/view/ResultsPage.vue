<template>
  <header class="header">
    <!-- TODO: 後で差し替える-->
    <img src="https://placehold.jp/150x150.png" alt="" class="header__logo" />
    <h1><router-link to="/" class="header__title">Sound Links</router-link></h1>
    <search-form class="search-form-wrapper__results"></search-form>
  </header>
  <main class="main-wrapper__results">
    <div v-show="store.state.isLoading" class="loader">Loading...</div>
    <results-list v-show="!store.state.isLoading" :results="store.state.results"></results-list>
  </main>
  <footer-component class="footer-wrapper__results"></footer-component>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { key } from "../store";
import { useStore } from "vuex";
import ResultsList from "../components/ResultsList";
import FooterComponent from "../components/Footer";
import SearchForm from "../components/SearchForm";

export default defineComponent({
  name: "ResultsPage",
  components: {
    SearchForm,
    ResultsList,
    FooterComponent,
  },
  setup() {
    const store = useStore(key);
    return {
      store,
    };
  },
});
</script>

<style scoped></style>
