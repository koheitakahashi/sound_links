<template>
  <result-page-header></result-page-header>
  <results-list :results="store.state.results"></results-list>
</template>

<script>
import { defineComponent } from "vue";
import { key } from "../store";
import { useStore } from "vuex";
import ResultPageHeader from "../components/resultPageHeader";
import resultsList from "../components/resultsList";

export default defineComponent({
  name: "ResultsPage",
  components: {
    ResultPageHeader,
    resultsList
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
