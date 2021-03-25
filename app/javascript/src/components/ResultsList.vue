<template>
  <div v-show="results.length !== 0" class="results-section">
    <h2 class="result-section__title">検索結果一覧</h2>
    <div
      class="result-section__list"
      v-for="result in results"
      :key="result.isrc"
    >
      <result :result="result"></result>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import Result from "./Result.vue";

export default defineComponent({
  name: "ResultList",
  components: {
    result: Result,
  },
  props: {
    results: {
      type: Array,
      default: () => [],
    },
  },
});
</script>

<style scoped></style>
