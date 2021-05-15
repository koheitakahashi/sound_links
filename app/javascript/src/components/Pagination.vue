<template>
  <nav class="pagination" data-test="pagination">
    <ul class="pagination__items">
      <li class="pagination-item__previous-link">
        <button @click="linkToPreviousPage()" data-test="pagination-previous-button">&lt;</button>
      </li>
      <li class="pagination__current-page" data-test="pagination-current-page-number">{{ store.state.currentPage }}ページ目</li>
      <li class="pagination-item__next-link">
        <button @click="linkToNextPage()" data-test="pagination-next-button">></button>
      </li>
    </ul>
  </nav>
</template>

<script lang="ts">
import { defineComponent, reactive } from "vue";
import { useStore } from "vuex";
import { useRouter, useRoute } from "vue-router";
import axios from "axios";
import { key } from "../store";

export default defineComponent({
  name: "Pagination",
  setup() {
    const router = useRouter();
    const route = useRoute();
    const store = useStore(key);

    // NOTE: page を含むURLに直接アクセスされた時に、 currentPage が正しく表示されるようにしている
    const setCurrentPage = function () {
      if (route.query.page) {
        // NOTE: route.query.keywords をそのまま state.keywords にいれると、route.query.keywordsが String 以外にもなり得るため代入できない
        let params = new URLSearchParams(window.location.search);
        store.commit("setCurrentPage", parseInt(params.get("page")))
      }
    }

    const linkToNextPage = async () => {
      // TODO: 共通化する
      try {
        await router.push({
          name: "ResultsPage",
          query: { keyword: store.state.keyword, page: store.state.currentPage + 1 }
        })

        store.commit("setIsLoading", true);
        await store.dispatch("updateCurrentPage", store.state.currentPage + 1)

        const response = await axios.get("search.json", {
          params: { keyword: store.state.keyword, page: store.state.currentPage },
        });

        await store.dispatch("updateResultsAndPage", response.data);
        store.commit("setIsLoading", false);
      } catch (error) {
        store.commit("setIsLoading", false);
        console.log(`Error! : ${error}`);
      }
    };

    const linkToPreviousPage = async () => {
      if (store.state.currentPage === 1)  {
        return
      }

      // TODO: 共通化する
      await router.push({
        name: "ResultsPage",
        query: { keyword: store.state.keyword, page: store.state.currentPage - 1 }
      })

      try {
        store.commit("setIsLoading", true);
        await store.dispatch("updateCurrentPage", store.state.currentPage - 1)

        const response = await axios.get("search.json", {
          params: { keyword: store.state.keyword, page: store.state.currentPage },
        });

        await store.dispatch("updateResultsAndPage", response.data);
        store.commit("setIsLoading", false);
      } catch (error) {
        store.commit("setIsLoading", false);
        console.log(`Error! : ${error}`);
      }
    }

    setCurrentPage()
    return{
      store,
      linkToNextPage,
      linkToPreviousPage,
    }
  }
})
</script>

<style scoped>

</style>
