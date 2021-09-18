<template>
    <h2 class="result-section__title" data-test="results-header">
      {{ resultHeaderText }}
    </h2>
    <div
      v-show="results.length === 0 && !store.getters.isLoading"
      class="result-section__no-message"
      data-test="no-result-message"
    >
      検索結果がありませんでした
    </div>
  <div class="result-items">
    <div
      v-for="result in results"
      :key="result.id"
      v-show="results.length !== 0"
      data-test="result"
      class="result-item"
    >
      <result :result="result"></result>
    </div>
  </div>
  <pagination></pagination>
</template>

<script lang="ts">
import { computed, defineComponent } from 'vue';
import { useStore } from 'vuex';
import Result from './Result.vue';
import Pagination from './Pagination.vue';

export default defineComponent({
  name: 'ResultList',
  components: {
    result: Result,
    pagination: Pagination,
  },
  props: {
    results: {
      type: Array,
      default: () => [],
    },
  },
  setup() {
    const store = useStore();
    const resultHeaderText = computed(() => `「${store.getters.keyword}」の検索結果`);

    return {
      store,
      resultHeaderText,
    };
  },
});
</script>

<style scoped></style>
