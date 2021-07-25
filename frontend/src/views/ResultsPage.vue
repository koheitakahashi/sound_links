<template>
  <header class="header--results">
    <h1><router-link to="/" class="header__title">Sound Links</router-link></h1>
    <search-form
      class="search-form-wrapper__results"
      parent-component="ResultsPage"
    ></search-form>
  </header>
  <main class="main-wrapper__results">
    <error-message v-show="store.getters.showError"></error-message>
    <div v-show="!store.getters.showError">
      <div v-show="store.getters.isLoading" class="loader">Loading...</div>
      <results
        v-show="!store.getters.isLoading"
        :results="store.getters.sortedResults"
      ></results>
    </div>
  </main>
  <footer-component class="footer-wrapper__results"></footer-component>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { useStore } from 'vuex';
import { useRoute } from 'vue-router';
import axios from 'axios';
// TODO: list が冗長なので名前を変更する
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

    // TODO: 不要かもしれない
    const setKeyword = async () => {
      if (route.query.keyword) {
        store.commit('setKeyword', route.query.keyword);
      }
    };

    // TODO: これを store に移動したほうがよいかもしれない
    const fetchResults = async () => {
      await setKeyword();
      try {
        store.commit('setIsLoading', true);
        const response = await axios.get('api/v1/search', {
          params: {
            keyword: store.getters.keyword,
            page: store.getters.currentPage,
          },
        });
        store.commit('setKeyword', store.getters.keyword);
        await store.dispatch('updateResultsAndPage', response.data);
        store.commit('setIsLoading', false);
      } catch (error) {
        store.commit('setIsLoading', false);
        store.commit('setShowError', true);
      }
    };

    fetchResults();

    return {
      store,
    };
  },
});
</script>

<style scoped></style>
