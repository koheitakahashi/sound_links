<template>
  <header>
    <h1>Sound Links</h1>
    <search-form></search-form>
  </header>
  <main>
    <results-list :results="store.state.results"></results-list>
  </main>
  <footer-component></footer-component>
</template>

<script>
import { defineComponent } from "vue";
import { key } from "../store";
import { useStore } from "vuex";
import ResultsList from "../components/ResultsList";
import FooterComponent from "../components/Footer";
import SearchForm from "../components/SearchForm";

export default defineComponent({
  name: "ResultsPage",
  components: {
    SearchForm,
    ResultsList,
    FooterComponent,
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
