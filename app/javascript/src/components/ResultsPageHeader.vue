<template>
  <h1>Sound Links</h1>
  <search-form></search-form>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import SearchForm from "./SearchForm.vue"

export default defineComponent({
  name: "ResultPageHeader",
  components: {
    SearchForm
  }
})
</script>

<style scoped>

</style>