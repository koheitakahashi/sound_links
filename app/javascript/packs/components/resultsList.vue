<template>
  <div>
    <div v-show="results.length !== 0">
      <h2>検索結果</h2>
      <table>
        <thead>
          <tr>
            <th>サムネイル</th>
            <th>楽曲名</th>
            <th>アーティスト名</th>
            <th>Spotify</th>
            <th>Apple Music</th>
            <th>KKBOX</th>
            <th></th>
          </tr>
        </thead>
        <tbody v-for="result in results" :key="result.isrc">
          <result :result="result"></result>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import result from "./result";

export default defineComponent({
  name: "ResultList",
  components: {
    result: result,
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
