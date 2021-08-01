<template>
  <nav class="pagination" data-test="pagination">
    <ul class="pagination__items">
      <li class="pagination-item__previous-link">
        <left-arrow-icon @click="linkToPage('previous')"></left-arrow-icon>
      </li>
      <li
        class="pagination-item__current-page"
        data-test="pagination-current-page-number"
      >
        {{ store.getters.currentPage }}ページ目
      </li>

      <li class="pagination-item__next-link">
        <right-arrow-icon @click="linkToPage('next')"></right-arrow-icon>
      </li>
    </ul>
  </nav>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import { useStore } from 'vuex';
import { useRouter, useRoute } from 'vue-router';
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

    const linkToPage = async (pageString: 'next' | 'previous') => {
      if (pageString === 'previous' && store.getters.currentPage <= minimumPageNumber) {
        return;
      }

      let linkToPageNumber: number;
      if (pageString === 'next') {
        linkToPageNumber = store.getters.currentPage + aroundCurrentPageNumber;
      } else {
        linkToPageNumber = store.getters.currentPage - aroundCurrentPageNumber;
      }

      await store.dispatch('updateCurrentPage', linkToPageNumber);
      try {
        await router.push({
          name: 'ResultsPage',
          query: {
            keyword: store.getters.keyword,
            page: linkToPageNumber,
          },
        });
        await store.dispatch('fetchResults');
      } catch (error) {
        store.commit('setIsLoading', false);
      }
    };

    setCurrentPage();
    return {
      store,
      linkToPage,
    };
  },
});
</script>

<style scoped></style>
