<template>
  <div>
    <search-form></search-form>
    <results-list :results="store.state.results"></results-list>
  </div>
</template>

<script>
import { defineComponent } from "vue";
import searchForm from "../components/searchForm";
import resultsList from "../components/resultsList"
import { key } from "../store";
import {useStore} from "vuex";


export default defineComponent({
  name: "ResultsPage",
  components: {
    searchForm,
    resultsList
  },
  setup() {
    const store = useStore(key);
    return {
      store
    }
  }
});
</script>

<style scoped></style>
