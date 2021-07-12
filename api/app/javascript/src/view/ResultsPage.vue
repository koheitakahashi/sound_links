<template>
  <header class="header--results">
    <h1><router-link to="/" class="header__title">Sound Links</router-link></h1>
    <search-form
      class="search-form-wrapper__results"
      parent-component="ResultsPage"
    ></search-form>
  </header>
  <main class="main-wrapper__results">
    <error-message v-show="store.state.showError"></error-message>
    <div v-show="!store.state.showError">
      <div v-show="store.state.isLoading" class="loader">Loading...</div>
      <results-list
        v-show="!store.state.isLoading"
        :results="store.state.results"
      ></results-list>
    </div>
  </main>
  <footer-component class="footer-wrapper__results"></footer-component>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { key } from "../store";
import { useStore } from "vuex";
import { useRoute } from "vue-router";
import axios from "axios";
import ResultsList from "../components/ResultsList";
import FooterComponent from "../components/Footer";
import SearchForm from "../components/SearchForm";
import ErrorMessage from "../components/ErrorMessage";

export default defineComponent({
  name: "ResultsPage",
  components: {
    SearchForm,
    ResultsList,
    FooterComponent,
    ErrorMessage,
  },
  setup() {
    const route = useRoute();
    const store = useStore(key);

    const setKeyword = async () => {
      if (route.query.keyword) {
        // NOTE: route.query.keywords をそのまま state.keywords にいれると、route.query.keywordsが String 以外にもなり得るため代入できない
        let params = new URLSearchParams(window.location.search);
        store.commit("setKeyword", params.get("keyword"));
      }
    };

    const setCurrentPage = function () {
      if (route.query.page) {
        let params = new URLSearchParams(window.location.search);
        store.commit("setCurrentPage", parseInt(params.get("page")));
      }
    };

    const fetchResults = async () => {
      await setKeyword();
      try {
        store.commit("setIsLoading", true);
        const response = await axios.get("search.json", {
          params: {
            keyword: store.state.keyword,
            page: store.state.currentPage,
          },
        });
        store.commit("setKeyword", store.state.keyword);
        await store.dispatch("updateResultsAndPage", response.data);
        store.commit("setIsLoading", false);
      } catch (error) {
        store.commit("setIsLoading", false);
        store.commit("setShowError", true);
      }
    };

    setCurrentPage();
    fetchResults();

    return {
      store,
    };
  },
});
</script>

<style scoped></style>
