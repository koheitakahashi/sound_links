<template>
  <search-form></search-form>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import SearchForm from "../components/searchForm.vue";

export default defineComponent({
  name: "TopPage",
  components: {
    SearchForm,
  },
});
</script>

<style scoped></style>
