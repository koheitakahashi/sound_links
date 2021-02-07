<template>
  <h1>Sound Links</h1>
  <search-form></search-form>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import SearchForm from "../components/searchForm"

export default defineComponent({
  name: "resultPageHeader",
  components: {
    SearchForm
  }
})
</script>

<style scoped>

</style>