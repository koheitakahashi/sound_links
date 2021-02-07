<template>
  <top-page-header></top-page-header>
  <search-form></search-form>
  <footer-component></footer-component>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import SearchForm from "../components/searchForm.vue";
import TopPageHeader from "../components/topPageHeader.vue"
import FooterComponent from "../components/footer"

export default defineComponent({
  name: "TopPage",
  components: {
    SearchForm,
    TopPageHeader,
    FooterComponent
  },
});
</script>

<style scoped></style>
