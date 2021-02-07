<template>
  <top-page-header></top-page-header>
  <search-form></search-form>
  <footer-component></footer-component>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import SearchForm from "../components/SearchForm.vue";
import TopPageHeader from "../components/TopPageHeader.vue"
import FooterComponent from "../components/Footer.vue"

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
