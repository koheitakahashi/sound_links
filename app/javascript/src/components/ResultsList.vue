<template>
  <div>
    <h2 class="result-section__title">検索結果一覧</h2>
    <pagination></pagination>
    <div
      v-show="results.length === 0 && !store.state.isLoading"
      class="results-message"
      data-test="no-result-message"
    >
      検索結果がありませんでした
    </div>
    <div
      class="result-section__list"
      v-for="result in results"
      :key="result.isrc"
      v-show="results.length !== 0"
    >
      <result :result="result"></result>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { useStore } from "vuex";
import { key } from "../store";
import Result from "./Result.vue";
import Pagination from "./Pagination.vue";

export default defineComponent({
  name: "ResultList",
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
    const store = useStore(key);
    return {
      store,
    };
  },
});
</script>

<style scoped></style>
