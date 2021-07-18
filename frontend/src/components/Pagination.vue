<template>
  <nav class="pagination" data-test="pagination">
    <ul class="pagination__items">
      <li class="pagination-item__previous-link">
        <left-arrow-icon @click="linkToPreviousPage()"></left-arrow-icon>
      </li>
      <li
        class="pagination-item__current-page"
        data-test="pagination-current-page-number"
      >
        {{ store.state.currentPage }}ページ目
      </li>

      <li class="pagination-item__next-link">
        <right-arrow-icon @click="linkToNextPage()"></right-arrow-icon>
      </li>
    </ul>
  </nav>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { useStore } from 'vuex';
import { useRouter, useRoute } from 'vue-router';
import axios from 'axios';
import RightArrowIcon from './fontAwesome/RightArrowIcon.vue';
import LeftArrowIcon from './fontAwesome/LeftArrowIcon.vue';

const minimumPageNumber = 1;
const aroundCurrentPageNumber = 1;

export default defineComponent({
  name: 'Pagination',
  components: { RightArrowIcon, LeftArrowIcon },
  setup() {
    const router = useRouter();
    const route = useRoute();
    const store = useStore();

    // NOTE: page を含むURLに直接アクセスされた時に、 currentPage が正しく表示されるようにしている
    function setCurrentPage() {
      const currentPageFromQuery = route.query.page;
      if (currentPageFromQuery) {
        store.commit('setCurrentPage', Number(currentPageFromQuery));
      }
    }

    const linkToNextPage = async () => {
      // TODO: 共通化する
      const nextPageNumber = store.state.currentPage + aroundCurrentPageNumber;
      try {
        await router.push({
          name: 'ResultsPage',
          query: {
            keyword: store.state.keyword,
            page: nextPageNumber,
          },
        });

        store.commit('setIsLoading', true);
        await store.dispatch('updateCurrentPage', nextPageNumber);

        const response = await axios.get('api/v1/search', {
          params: {
            keyword: store.state.keyword,
            page: store.state.currentPage,
          },
        });

        await store.dispatch('updateResultsAndPage', response.data);
        store.commit('setIsLoading', false);
      } catch (error) {
        store.commit('setIsLoading', false);
      }
    };

    const linkToPreviousPage = async () => {
      if (store.state.currentPage === minimumPageNumber) {
        return;
      }

      // TODO: 共通化する
      const previousPageNumber = store.state.currentPage - aroundCurrentPageNumber;
      await router.push({
        name: 'ResultsPage',
        query: {
          keyword: store.state.keyword,
          page: previousPageNumber,
        },
      });

      try {
        store.commit('setIsLoading', true);
        await store.dispatch('updateCurrentPage', previousPageNumber);

        const response = await axios.get('api/v1/search', {
          params: {
            keyword: store.state.keyword,
            page: store.state.currentPage,
          },
        });

        await store.dispatch('updateResultsAndPage', response.data);
        store.commit('setIsLoading', false);
      } catch (error) {
        store.commit('setIsLoading', false);
      }
    };

    setCurrentPage();
    return {
      store,
      linkToNextPage,
      linkToPreviousPage,
    };
  },
});
</script>

<style scoped></style>
