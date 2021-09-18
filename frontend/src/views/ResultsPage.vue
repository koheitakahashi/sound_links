<template>
  <header class="header--results">
    <router-link to="/">
      <img src="/img/logo.svg" alt="SoundLinksのロゴ" class="header__logo">
    </router-link>
    <search-form
      class="search-form-wrapper__results"
      parent-component="ResultsPage"
    ></search-form>
  </header>
  <main class="main-wrapper__results">
    <error-message v-show="store.getters.showError"></error-message>
    <div class="result-list">
      <div v-show="!store.getters.showError">
        <div v-show="store.getters.isLoading" class="loader">Loading...</div>
        <results
          v-show="!store.getters.isLoading"
          :results="store.getters.sortedResults"
        ></results>
      </div>
    </div>
  </main>
  <footer-component class="footer-wrapper__results"></footer-component>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { useStore } from 'vuex';
import { useRoute } from 'vue-router';
import Results from '@/components/Results.vue';
import FooterComponent from '@/components/Footer.vue';
import SearchForm from '@/components/SearchForm.vue';
import ErrorMessage from '@/components/ErrorMessage.vue';

export default defineComponent({
  name: 'ResultsPage',
  components: {
    SearchForm,
    Results,
    FooterComponent,
    ErrorMessage,
  },
  setup() {
    const route = useRoute();
    const store = useStore();

    const fetchResults = async () => {
      await store.dispatch('updateKeyword', route.query.keyword);
      await store.dispatch('fetchResults');
    };

    fetchResults();

    return {
      store,
    };
  },
});
</script>

<style scoped></style>
