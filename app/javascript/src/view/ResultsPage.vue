<template>
  <header class="header--results">
    <!-- TODO: 後で差し替える-->
    <img src="https://placehold.jp/150x150.png" alt="" class="header__logo" />
    <h1><router-link to="/" class="header__title">Sound Links</router-link></h1>
    <search-form class="search-form-wrapper__results"></search-form>
  </header>
  <main class="main-wrapper__results">
    <div v-show="store.state.isLoading" class="loader">Loading...</div>
    <results-list
      v-show="!store.state.isLoading"
      :results="store.state.results"
    ></results-list>
  </main>
  <footer-component class="footer-wrapper__results"></footer-component>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { key } from "../store";
import { useStore } from "vuex";
import axios from "axios";
import ResultsList from "../components/ResultsList";
import FooterComponent from "../components/Footer";
import SearchForm from "../components/SearchForm";
import { useRoute } from "vue-router";

export default defineComponent({
  name: "ResultsPage",
  components: {
    SearchForm,
    ResultsList,
    FooterComponent,
  },
  setup() {
    const route = useRoute();
    const store = useStore(key);

    const setKeyword = async () => {
      if (route.query.keyword) {
        // NOTE: route.query.keywords をそのまま state.keywords にいれると、route.query.keywordsが String 以外にもなり得るため代入できない
        let params = new URLSearchParams(window.location.search);
        store.commit("setKeyword", params.get("keyword"))
      }
    }

    const setCurrentPage = function () {
      if (route.query.page) {
        let params = new URLSearchParams(window.location.search);
        store.commit("setCurrentPage", parseInt(params.get("page")))
      }
    }

    const fetchResults = async () => {
      await setKeyword()
      try {
        store.commit("setIsLoading", true);
        const response = await axios.get("search.json", {
          params: { keyword: store.state.keyword, page: store.state.currentPage },
        });
        store.commit("setKeyword", store.state.keyword);
        await store.dispatch("updateResultsAndPage", response.data);
        store.commit("setIsLoading", false);
      } catch (error) {
        store.commit("setIsLoading", false);
        console.log(`Error! : ${error}`);
      }
    }

    setCurrentPage()
    fetchResults()

    return {
      store,
    };
  },
});
</script>

<style scoped></style>
